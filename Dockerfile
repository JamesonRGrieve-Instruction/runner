FROM ubuntu:20.04

ARG RUNNER_VERSION="2.317.0"

ARG DEBIAN_FRONTEND=noninteractive

ARG REPO
ARG TOKEN

ENV REPO=$REPO
ENV TOKEN=$TOKEN

RUN apt-get update && apt-get -y install --no-install-recommends sudo bash curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN curl -sSL https://get.docker.com/ | sudo sh
RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz 
RUN ls -a
RUN /app/actions-runner/bin/installdependencies.sh
RUN mkdir /app/scripts
COPY /scripts/ /app/scripts/
RUN chmod +x /app/scripts/start.sh
ENTRYPOINT ["/home/docker/scripts/start.sh"]