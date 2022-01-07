#!/bin/bash -e

if [[ "$@" == "bash" ]]; then
    exec $@
    exit
fi

RUNNER_NAME_PREFIX=${RUNNER_NAME_PREFIX:="qulacsosaka-ubuntu-ci"}
RUNNER_NAME="${RUNNER_NAME_PREFIX}_$(uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | cat)"
RUNNER_WORK_DIRECTORY=${RUNNER_WORK_DIRECTORY:="/_work"}
RUNNER_REPOSITORY_URL=${RUNNER_REPOSITORY_URL:="https://github.com/Qulacs-Osaka/qulacs-osaka"}
LABELS=${LABELS:="ubuntu-self-hosted"}

# Get GitHub access token here with "repo" and "workflow" control : https://github.com/settings/tokens
if [[ -z $RUNNER_TOKEN && -z $GITHUB_ACCESS_TOKEN ]]; then
    echo "Error : You need to set RUNNER_TOKEN or GITHUB_ACCESS_TOKEN environment variable."
    exit 1
fi

if [[ -n $GITHUB_ACCESS_TOKEN ]]; then
    TOKEN=$(bash ./fetch_token.sh "${RUNNER_REPOSITORY_URL}")
    RUNNER_TOKEN=$(echo "${TOKEN}" | jq -r .token)
    RUNNER_URL=$(echo "${TOKEN}" | jq -r .url)
fi

echo "Configuring"
./config.sh \
    --url "$RUNNER_URL" \
    --token "$RUNNER_TOKEN" \
    --name "$RUNNER_NAME" \
    --labels "$LABELS" \
    --work "$RUNNER_WORK_DIRECTORY" \
    --unattended

mkdir -p $RUNNER_WORK_DIRECTORY

unset "$RUNNER_TOKEN"

./bin/runsvc.sh
