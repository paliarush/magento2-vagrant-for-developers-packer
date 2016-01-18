# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_API_VERSION = 2
Vagrant.configure(VAGRANT_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.name = "magento2.ubuntu-14.04"
    end

    config.vm.provision "install_environment", type: "shell" do |s|
        s.path = "scripts/vagrant/install_magento_environment.sh"
    end
end
