#!/usr/bin/env bash

set -e

export version=$(cat candidate-version/version)
export ROOT_PATH=$PWD

mv bosh-cli/bosh-cli-*-linux-amd64 bosh-cli/bosh-cli
export GO_CLI_PATH=$ROOT_PATH/bosh-cli/bosh-cli
chmod +x $GO_CLI_PATH

cd bosh-src

sed -i -E "s/VERSION = .+/VERSION = '$version'/" $( find src -name version.rb )

$GO_CLI_PATH create-release --tarball=../release/bosh-dev-release.tgz --timestamp-version --force
