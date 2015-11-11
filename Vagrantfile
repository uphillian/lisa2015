# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define "lisa" do |lisa|
    lisa.vm.box = "lisa2015"
    lisa.vm.hostname = "lisa2015"
  end

  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8140, host: 8140
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
#  config.vm.provision "shell", inline: <<-SHELL
#     sudo 
#     sudo apt-get install -y apache2
#  SHELL
end
