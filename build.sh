#!/usr/bin/env bash

vagrant up
VBoxManage export magento2.vagrant.packer -o magento2.vagrant.packer.ova --ovf20
vagrant destroy
packer build template.json