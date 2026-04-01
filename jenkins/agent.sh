cat *
#!/bin/bash

set -e

echo "Waiting for Jenkins to start..."
sleep 15

echo "Registering '${JENKINS_AGENT_NAME}' with the controller..."

# Retrieve the agent secret from its metadata endpoint.
AGENT_ENDPOINT="${JENKINS_URL}/computer/${JENKINS_AGENT_NAME}/jenkins-agent.jnlp"
AGENT_METADATA="$(curl -s -X GET -u "${JENKINS_AGENT_USERNAME}:${JENKINS_AGENT_PASSWORD}" $AGENT_ENDPOINT)"
AGENT_SECRET="$(echo $AGENT_METADATA | sed "s/.*<application-desc><argument>\([a-z0-9]*\).*/\1\n/")"

echo "Starting '${JENKINS_AGENT_NAME}'..."
export JENKINS_SECRET="$AGENT_SECRET"
export JENKINS_AGENT_NAME="$JENKINS_AGENT_NAME"
export JENKINS_URL="$JENKINS_URL"
exec jenkins-agent