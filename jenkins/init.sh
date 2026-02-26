#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

# Install Jenkins dependencies.
apt-get update
apt-get install -y wget gnupg curl openjdk-21-jdk

# Install Jenkins.
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get install -y jenkins

# Make sure jenkins.yaml and plugins.txt and exist.
ls -al /usr/share/jenkins/ref/jenkins.yaml
ls -al /usr/share/jenkins/ref/plugins.txt

# Download the Jenkins Plugin Installation Manager.
wget -O /tmp/jenkins-plugin-manager.jar https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.13/jenkins-plugin-manager-2.12.13.jar

# Run the plugin manager to install the plugins listed in plugins.txt.
java -jar /tmp/jenkins-plugin-manager.jar \
  --war /usr/share/java/jenkins.war \
  --plugin-file /usr/share/jenkins/ref/plugins.txt \
  --plugin-download-directory /var/lib/jenkins/plugins

# Set required environment variables.
export JENKINS_HOME=/var/lib/jenkins
export JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
export CASC_JENKINS_CONFIG="/usr/share/jenkins/ref/jenkins.yaml"

# Start Jenkins.
# systemctl start jenkins # Or just `jenkins`, to start.