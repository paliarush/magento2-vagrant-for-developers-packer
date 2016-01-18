#!/usr/bin/env bash

# Enable trace printing and exit on the first error
set -ex

vagrant up
vagrant halt
VBoxManage export -o "magento2.ubuntu-14.04.ova" --ovf20 "magento2.ubuntu-14.04"
vagrant destroy -f
packer build template.json