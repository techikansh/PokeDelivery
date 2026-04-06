#!/bin/bash
set -e

JENKINS_URL="http://jenkins:8080"
AGENT_NAME="artifact-agent-1"

echo "-----Waiting for Jenkins-----"
until curl -sf "${JENKINS_URL}/login" > /dev/null; do sleep 5; done
echo "-----Jenkins is up-----"

echo "-----Fetching agent secret-----"
SECRET=$(curl -sf -u "admin:${JENKINS_ADMIN_PASSWORD}" \
  "${JENKINS_URL}/computer/${AGENT_NAME}/slave-agent.jnlp" \
  | grep -oP '[a-f0-9]{64}' | head -1)

echo "-----Starting agent-----"
exec java -jar /usr/share/jenkins/agent.jar \
  -url "${JENKINS_URL}" \
  -name "${AGENT_NAME}" \
  -secret "${SECRET}" \
  -webSocket