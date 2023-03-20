# base image
FROM ubuntu:22.04

#input GitHub runner version argument
ARG RUNNER_VERSION
ARG RUNNER_TOKEN
ARG TERRAFORM_VERSION
ARG POWERSHELL_VERSION
ARG ORGANISATION
ARG REPOSITORY
ENV DEBIAN_FRONTEND=noninteractive

LABEL BaseImage="ubuntu:22.04"
LABEL BaseImage="TERRAFORM_VERSION:${TERRAFORM_VERSION}"
LABEL BaseImage="POWERSHELL_VERSION:${POWERSHELL_VERSION}"
LABEL RunnerVersion=${RUNNER_VERSION}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl nodejs wget unzip vim git jq build-essential libssl-dev \
    libffi-dev python3.11 python3-venv python3-dev python3-pip \
    && apt-get clean

RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/bin \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v${POWERSHELL_VERSION}/powershell-${POWERSHELL_VERSION}-linux-x64.tar.gz \
    && sudo mkdir -p /opt/microsoft/powershell/7 \
    && sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 \
    && sudo chmod +x /opt/microsoft/powershell/7/pwsh \
    && sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

RUN curl -L https://aka.ms/InstallAzureCli | bash

RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && ./config.sh --url https://github.com/${ORGANISATION}/${REPOSITORY} --token ${GITHUB_TOKEN} \
    && rm -f ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# set the entrypoint to the start.sh script
ENTRYPOINT ["./run.sh"]