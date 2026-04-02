FROM jenkins/jenkins:lts-jdk17

USER root

RUN apt-get update && apt-get install -y \
    curl \
    jq \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN jenkins-plugin-cli --plugins "workflow-aggregator git configuration-as-code"

USER jenkins