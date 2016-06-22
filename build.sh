#!/usr/bin/env bash

# Configuration
path_to_tests="../magento2-vagrant-for-developers-tests"

# Enable trace printing and exit on the first error
set -ex

# Clear environment
vagrant destroy -f
rm -f magento2.ubuntu-14.04.ova
rm -f packer_virtualbox-ovf_virtualbox.box

# Build box
vagrant up
vagrant halt
VBoxManage export -o "magento2.ubuntu-14.04.ova" --ovf20 "magento2.ubuntu-14.04"
vagrant destroy -f
./scripts/packer/packer build template.json
vagrant box remove --force paliarush/magento2.ubuntu.rc
vagrant box add paliarush/magento2.ubuntu.rc packer_virtualbox-ovf_virtualbox.box

# Run tests
cd ${path_to_tests}
bash ./testsuite.sh