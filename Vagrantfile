# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "minimal/trusty64"
  config.vm.hostname = "vagrant"
  config.vm.provision "shell", path: "provision.sh"
  config.vm.provision "shell", inline: "sudo service nginx restart", run: "always"

  config.vm.network "forwarded_port", guest: 80,    host: 8080

  config.vm.network "private_network", ip: "10.4.4.4"

  config.vm.synced_folder '.', '/srv', nfs: true
  config.vm.synced_folder './etc/nginx/sites-available', '/etc/nginx/sites-available', nfs: true
  config.vm.synced_folder './etc/nginx/ssl', '/etc/nginx/ssl', nfs: true

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 1536

    v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    v.customize ["modifyvm", :id, "--acpi", "off"]
  end
end
