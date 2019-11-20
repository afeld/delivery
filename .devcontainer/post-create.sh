#!/bin/bash

set -e
set -x


# downgrade the Azure CLI - temporary workaround for unreleased bug fix
# https://github.com/Azure/azure-cli/issues/11221
sudo apt-get update
sudo apt-get install --assume-yes --allow-downgrades azure-cli=2.0.75-1~stretch
