#!/bin/bash -eu

# Fetch token to use configure runner using GitHub Access Token dynamically.

SCOPE="repos"
RUNNER_REPOSITORY_URL=${1:="https://github.com/Qulacs-Osaka/qulacs-osaka"}

# Access API to get runner token.
PROTO="$(echo "${RUNNER_REPOSITORY_URL}" | grep :// | sed -e's,^\(.*://\).*,\1,g')"
URL="${RUNNER_REPOSITORY_URL/${PROTO}/}"
REPO="$(echo "${URL}" | grep / | cut -d/ -f2-)"

API_HEADER="Authorization: token ${GITHUB_ACCESS_TOKEN}"
AUTH_HEADER="Accept: application/vnd.github.v3+json"
API_URL="https://api.github.com/${SCOPE}/${REPO}/actions/runners/registration-token"

RUNNER_TOKEN="$(curl -XPOST -fsSL \
    -H "${API_HEADER}" \
    -H "${AUTH_HEADER}" \
    "${API_URL}" |
    jq -r .token)"

echo "{\"token\": \"${RUNNER_TOKEN}\", \"url\": \"${RUNNER_REPOSITORY_URL}\"}"
