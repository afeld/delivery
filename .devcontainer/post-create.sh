#!/bin/bash

set -e
set -x

# generate SSH key
# https://unix.stackexchange.com/a/69318
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -q -N "" -C vsonline
# disable host key checking
printf "Host *\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null\n" > ~/.ssh/config

# downgrade the Azure CLI - temporary workaround for unreleased bug fix
# https://github.com/Azure/azure-cli/issues/11221
sudo apt-get update
sudo apt-get install --assume-yes --allow-downgrades azure-cli=2.0.75-1~stretch
