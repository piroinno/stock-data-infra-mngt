# base image
FROM ubuntu:20.04

#input GitHub runner version argument
ARG RUNNER_VERSION
ARG RUNNER_TOKEN
ARG ORGANISATION
ARG REPOSITORY
ENV DEBIAN_FRONTEND=noninteractive

LABEL BaseImage="ubuntu:20.04"
LABEL RunnerVersion=${RUNNER_VERSION}

RUN apt-get install -y --no-install-recommends

RUN apt-get install -y --no-install-recommends \
    curl nodejs wget unzip vim git azure-cli jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip \
    terraform=0.14.0 \
    && apt-get clean

RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && ./config.sh --url https://github.com/${ORGANISATION}/${REPOSITORY} --token ${GITHUB_TOKEN} \
    && rm -f ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# set the entrypoint to the start.sh script
ENTRYPOINT ["./run.sh"]