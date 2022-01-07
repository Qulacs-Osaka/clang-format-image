#!/bin/bash -eu

# Installs GitHub Actions runner and its dependencies.
# Specify OS and architecture on which runners run in command line argument.

# Variant: "linux", "osx", "win"
TARGET_OS=${1:-"linux"}
# Variant: "x64", "arm64"
TARGET_ARCH=${2:-"x64"}
GH_RUNNER_VERSION=${GH_RUNNER_VERSION:-$(curl -s "https://api.github.com/repos/actions/runner/releases/latest" | grep tag_name | sed -E 's/.*"v([^"]+)".*/\1/')}

curl -L -O "https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-${TARGET_OS}-${TARGET_ARCH}-${GH_RUNNER_VERSION}.tar.gz"
tar -zxf "actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz"
rm -f "actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz"
./bin/installdependencies.sh
