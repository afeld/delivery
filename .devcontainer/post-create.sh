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
# also install Python 2, as Ansible is using a version of azure-cli that is incompatible with Python 3.8
sudo apt-get update
sudo apt-get install --assume-yes --allow-downgrades \
  azure-cli=2.0.75-1~stretch \
  python-pip

# install Terraform
TF_VERSION=0.12.16
TF_URL=https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
curl ${TF_URL} > /tmp/terraform.zip
sudo unzip -o /tmp/terraform.zip -d /usr/local/bin

pip2 install --user --upgrade 'ansible[azure]'

az configure --defaults location="Australia Central"
