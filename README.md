# Box packer configuration for Magento 2 Vagrant project

Current project allows creation of vagrant boxes for [Magento 2 Vagrant project](https://github.com/paliarush/magento2-vagrant-for-developers).
Existing versions of this box can be found at the official Vagrant [box hosting](https://atlas.hashicorp.com/paliarush/boxes/magento2.ubuntu).

## What you get

**magento2.ubuntu-14.04** box based on **ubuntu/trusty64** box with software installed by [scripts/vagrant/install_magento_environment.sh](scripts/vagrant/install_magento_environment.sh).

## Requirements

 - [Vagrant 1.8+](https://www.vagrantup.com/downloads.html)
 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 
 - [Packer](https://www.packer.io/downloads.html)

## Usage

 1. Execute `bash build.sh`, which will generate box in the project root
 1. Upload created box using [Atlas Web Interface](https://atlas.hashicorp.com/help/vagrant/boxes/create)