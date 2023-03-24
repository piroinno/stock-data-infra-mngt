# base image
FROM ubuntu:22.04

#input GitHub runner version argument
ARG RUNNER_VERSION
ARG TERRAFORM_VERSION
ARG POWERSHELL_VERSION
ARG ORGANISATION
ARG REPOSITORY
ENV DEBIAN_FRONTEND=noninteractive

LABEL BaseImage="ubuntu:22.04"
LABEL BaseImage="TERRAFORM_VERSION:${TERRAFORM_VERSION}"
LABEL BaseImage="POWERSHELL_VERSION:${POWERSHELL_VERSION}"
LABEL RunnerVersion=${RUNNER_VERSION}

RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl nodejs wget unzip vim git jq build-essential libssl-dev \
    libffi-dev python3 python3-venv python3-dev python3-pip \
    apt-transport-https software-properties-common libssl1.0 \
    && apt-get clean

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/bin \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && add-apt-repository universe \
    && apt-get install -y powershell

RUN cd /home/docker && mkdir actions-runner
WORKDIR /home/docker/actions-runner

RUN cd /home/docker/actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

ADD runner.sh runner.sh
RUN chmod +x runner.sh

USER docker

ENTRYPOINT ["./runner.sh"]