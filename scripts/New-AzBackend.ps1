[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $JsonConfigurationFilePath
)

begin {
    Write-Verbose "Begining $($MyInvocation.MyCommand.Name)"
    $ErrorActionPreference = "Stop"
    if (Test-Path $JsonConfigurationFilePath) {
        $IacConfiguration = (Get-Content $JsonConfigurationFilePath | ConvertFrom-Json).iac
    }
    else {
        Write-Error "JsonConfigurationFilePath does not exist"
    }

    if ((Get-AzContext -ErrorAction 0).Tenant.Id -ne $IacConfiguration.properties.tenant_id) {
        Write-Host "Please login to Azure"
        Connect-AzAccount -Tenant $IacConfiguration.properties.tenant_id
    }

    $AdminLocalIP = (Invoke-WebRequest -Uri "https://api.ipify.org").Content

    if((Get-AzADGroup -DisplayName "Terraform Admins" -ErrorAction 0)) {
        Write-Warning "Terraform Admins group already exists"
        $TfAdminGroup = (Get-AzADGroup -DisplayName "Terraform Admins")
    }
    else {
        $TfAdminGroup = New-AzADGroup -DisplayName "Terraform Admins" -MailNickname "TerraformAdmins" -SecurityEnabled
    }
    if((Get-AzADGroup -DisplayName "Terraform Users" -ErrorAction 0)) {
        Write-Warning "Terraform Users group already exists"
        $TfUserGroup = (Get-AzADGroup -DisplayName "Terraform Users")
    }
    else {
        $TfUserGroup = New-AzADGroup -DisplayName "Terraform Users" -MailNickname "TerraformUsers" -SecurityEnabled
    }
    if((Get-AzADGroup -DisplayName "Terraform Service Principals" -ErrorAction 0)) {
        Write-Warning "Terraform Service Principals group already exists"
        $TfSpnGroup = (Get-AzADGroup -DisplayName "Terraform Service Principals")
    }
    else {
        $TfSpnGroup = New-AzADGroup -DisplayName "Terraform Service Principals" -MailNickname "TerraformServicePrincipals" -SecurityEnabled
    }

    if((Get-AzADGroupMember -GroupObjectId $TfSpnGroup.Id -ErrorAction 0 | ?{$_.Id -eq $SPN.Id})) {
        Write-Warning "Service principal $SPNConfiguration.name already exists in Terraform Service Principals group"
    }
    else {
        Add-AzADGroupMember -TargetGroupObjectId $TfSpnGroup.Id -MemberObjectId $SPN.Id
    }
}

process {
    Write-Verbose "Processing $($MyInvocation.MyCommand.Name)"
    Write-Host "Creating backend storage account"
    $SAConfiguration = $IacConfiguration.terraform_backend.storage_account
    if ((Get-AzContext).Subscription.Id -ne $SAConfiguration.subscription_id) {
        Set-AzContext -SubscriptionId $SAConfiguration.subscription_id
    }
    if ((Get-AzResourceProvider -ProviderNamespace Microsoft.Storage -ErrorAction 0).RegistrationState -eq "Registered") {
        Write-Warning "Microsoft.Storage resource provider already registered"
    }
    else {
        Register-AzResourceProvider -ProviderNamespace Microsoft.Storage -ConsentToPermissions $true
    }
    if ((Get-AzResourceProvider -ProviderNamespace Microsoft.KeyVault -ErrorAction 0).RegistrationState -eq "Registered") {
        Write-Warning "Microsoft.KeyVault resource provider already registered"
    }
    else {
        Register-AzResourceProvider -ProviderNamespace Microsoft.KeyVault -ConsentToPermissions $true
    }

    $SAResurceGroup = (Get-AzResourceGroup -Name $SAConfiguration.resource_group_name -ErrorAction 0)
    if ($SAResurceGroup) {
        Write-Warning "Resource group $SAConfiguration.resource_group_name already exists"
    }
    else {
        $SAResurceGroup = New-AzResourceGroup -Name $SAConfiguration.resource_group_name `
            -Location $IacConfiguration.properties.location
    }
    $SASubscription = (Get-AzSubscription -SubscriptionId $SAConfiguration.subscription_id)
    if((Get-AzRoleAssignment -ObjectId $TfAdminGroup.Id -Scope "/subscriptions/$($SASubscription.Id)" -ErrorAction 0 | ?{$_.RoleDefinitionName -eq "Owner"})) {
        Write-Warning "Terraform Admins already has Owner role on $SASubscription.Name"
    }
    else {
        New-AzRoleAssignment -ObjectId $TfAdminGroup.Id `
            -RoleDefinitionName "Owner" `
            -Scope "/subscriptions/$($SASubscription.Id)"
    }
    if((Get-AzRoleAssignment -ObjectId $TfSpnGroup.Id -Scope "/subscriptions/$($SASubscription.Id)" -ErrorAction 0) | ?{$_.RoleDefinitionName -eq "Contributor"}) {
        Write-Warning "Terraform Service Principals already has Contributor role on $SASubscription.Name"
    }
    else {
        New-AzRoleAssignment -ObjectId $TfSpnGroup.Id `
            -RoleDefinitionName "Contributor" `
            -Scope "/subscriptions/$($SASubscription.Id)" 
    }
    if((Get-AzRoleAssignment -ObjectId $TfUserGroup.Id -Scope "/subscriptions/$($SASubscription.Id)" -ErrorAction 0)) {
        Write-Warning "Terraform Users already has Reader role on $SASubscription.Name"
    }
    else {
        New-AzRoleAssignment -ObjectId $TfUserGroup.Id `
            -RoleDefinitionName "Reader" `
            -Scope "/subscriptions/$($SASubscription.Id)"
    }
    $StorageAccount = (Get-AzStorageAccount -ResourceGroupName $SAConfiguration.resource_group_name -Name $SAConfiguration.name -ErrorAction 0)
    if ($StorageAccount) {
        Write-Warning "Storage account $SAConfiguration.name already exists"
        Add-AzStorageAccountNetworkRule -ResourceGroupName $SAConfiguration.resource_group_name `
            -AccountName $SAConfiguration.name `
            -IPRule (@{IPAddressOrRange = $AdminLocalIP; Action = "allow" })
    }
    else {
        $StorageAccount = New-AzStorageAccount -ResourceGroupName $SAConfiguration.resource_group_name `
            -Name $SAConfiguration.name `
            -Location $IacConfiguration.properties.location `
            -SkuName $SAConfiguration.sku_name `
            -Kind $SAConfiguration.kind `
            -AccessTier $SAConfiguration.access_tier `
            -EnableHttpsTrafficOnly $SAConfiguration.enable_https_traffic_only `
            -EnableHierarchicalNamespace $SAConfiguration.enable_hierarchical_namespace
    }
    if((Get-AzRoleAssignment -ObjectId $TfAdminGroup.Id -Scope $StorageAccount.Id -ErrorAction 0)) {
        Write-Warning "Terraform Admins already has Storage Blob Data Contributor role on $StorageAccount.Name"
    }
    else {
        New-AzRoleAssignment -ObjectId $TfAdminGroup.Id `
            -RoleDefinitionName "Storage Blob Data Owner" `
            -Scope $StorageAccount.Id
    }
    if((Get-AzRoleAssignment -ObjectId $TfSpnGroup.Id -Scope $StorageAccount.Id -ErrorAction 0)) {
        Write-Warning "Terraform Service Principals already has Storage Blob Data Contributor role on $StorageAccount.Name"
    }
    else {
        New-AzRoleAssignment -ObjectId $TfSpnGroup.Id `
            -RoleDefinitionName "Storage Blob Data Contributor" `
            -Scope $StorageAccount.Id
    }
    if((Get-AzRoleAssignment -ObjectId $TfUserGroup.Id -Scope $StorageAccount.Id -ErrorAction 0)) {
        Write-Warning "Terraform Users already has Storage Blob Data Contributor role on $StorageAccount.Name"
    }
    else {
        New-AzRoleAssignment -ObjectId $TfUserGroup.Id `
            -RoleDefinitionName "Storage Blob Data Reader" `
            -Scope $StorageAccount.Id
    }
    Write-Host "Creating backend container"
    if ((Get-AzStorageContainer -Name $SAConfiguration.container_name -Context $StorageAccount.Context -ErrorAction 0)) {
        Write-Warning "Container $SAConfiguration.container_name already exists"
    }
    else {
        New-AzStorageContainer -Name $SAConfiguration.container_name -Context $StorageAccount.Context
    }

    Write-Host "Creating backend key vault service principal"
    $SPNConfigurations = $IacConfiguration.terraform_backend.service_principals
    foreach ($SPNConfiguration in $SPNConfigurations) {
        if ((Get-AzContext).Subscription.Id -ne $SPNConfiguration.key_vault.subscription_id) {
            Set-AzContext -SubscriptionId $SPNConfiguration.key_vault.subscription_id
        }
        if ((Get-AzResourceGroup -Name $SPNConfiguration.key_vault.resource_group_name -ErrorAction 0)) {
            Write-Warning "Resource group $($SPNConfiguration.key_vault.resource_group_name) already exists"
        }
        else {
            New-AzResourceGroup -Name $SPNConfiguration.key_vault.resource_group_name `
                -Location $IacConfiguration.properties.location
        }
        $SPNKeyVault = (Get-AzKeyVault -VaultName $SPNConfiguration.key_vault.name -ResourceGroupName $SPNConfiguration.key_vault.resource_group_name -ErrorAction 0)
        if ($SPNKeyVault) {
            Write-Warning "Key vault $SPNConfiguration.key_vault.name already exists"
        }
        else {
            $NetRuleSet = New-AzKeyVaultNetworkRuleSetObject -DefaultAction Deny `
                -IpAddressRange @($AdminLocalIP) `
                -Bypass AzureServices
            New-AzKeyVault -VaultName $SPNConfiguration.key_vault.name `
                -ResourceGroupName $SPNConfiguration.key_vault.resource_group_name `
                -Location $IacConfiguration.properties.location `
                -Sku $SPNConfiguration.key_vault.sku `
                -EnabledForDeployment:$SPNConfiguration.key_vault.enabled_for_deployment `
                -EnabledForTemplateDeployment:$SPNConfiguration.key_vault.enabled_for_template_deployment `
                -EnabledForDiskEncryption:$SPNConfiguration.key_vault.enabled_for_disk_encryption `
                -SoftDeleteRetentionInDays $SPNConfiguration.key_vault.soft_delete_retention_in_days `
                -EnablePurgeProtection:$SPNConfiguration.key_vault.enable_purge_protection `
                -NetworkRuleSet $NetRuleSet
        }
        $SPNKeyVaultSecret = Get-AzKeyVaultSecret -VaultName $SPNConfiguration.key_vault.name -Name $SPNConfiguration.key_vault.secret_name -ErrorAction 0
        if (($SPNKeyVaultSecret)) {
            Write-Warning "Key vault secret $SPNConfiguration.name already exists"
        }
        else {
            $SPNKeyVaultSecret = Set-AzKeyVaultSecret -VaultName $SPNConfiguration.key_vault.name `
                -Name $SPNConfiguration.key_vault.secret_name `
                -SecretValue ((New-Guid).Guid | ConvertTo-SecureString -AsPlainText -Force)
        }

        if ((Get-AzADServicePrincipal -DisplayName $SPNConfiguration.name -ErrorAction 0)) {
            Write-Warning "Service principal $SPNConfiguration.name already exists"
        }
        else {
            $SPN = New-AzADServicePrincipal -DisplayName $SPNConfiguration.name
            $SPN | New-AzADSpCredential -StartDate (Get-Date).Date -EndDate (Get-Date).Date.AddMonths(2)
        }
        if((Get-AzADGroupMember -GroupObjectId $TfSpnGroup.Id -ErrorAction 0 | ?{$_.Id -eq $SPN.Id})) {
            Write-Warning "Service principal $SPNConfiguration.name already exists in Terraform Service Principals group"
        }
        else {
            Add-AzADGroupMember -TargetGroupObjectId $TfSpnGroup.Id -MemberObjectId $SPN.Id
        }
        $SPNKeyVault = Get-AzKeyVault -VaultName $SPNConfiguration.key_vault.name -ResourceGroupName $SPNConfiguration.key_vault.resource_group_name
        if(Get-AzRoleAssignment -ObjectId $SPN.Id -Scope $SPNKeyVault.ResourceId -ErrorAction 0) {
            Write-Warning "Service principal $SPNConfiguration.name already has Key Vault Secret Officer role on $SPNConfiguration.key_vault.name"
        }
        else {
            New-AzRoleAssignment -ObjectId $SPN.Id `
                -RoleDefinitionName "Key Vault Secrets Officer" `
                -Scope $SPNKeyVault.ResourceId
        }
    }
}

end {
    Write-Verbose "Ending $($MyInvocation.MyCommand.Name)"
}