# Box packer configuration for Magento 2 Vagrant project

This repository contains [Packer configuration](https://www.packer.io/docs/builders/virtualbox-ovf.html) which allows to create boxes for [Magento 2 Vagrant project](https://github.com/paliarush/magento2-vagrant-for-developers-packer)

## Usage

 1. Export virtual machine as `magento2.ubuntu.ovf` in OVF 2.0 format to the root of current project
 2. Run `packer build template.json`
 3. Upload created box using [Atlas Web Interface](https://atlas.hashicorp.com/help/vagrant/boxes/create)