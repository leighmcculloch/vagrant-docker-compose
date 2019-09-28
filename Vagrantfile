# -*- mode: ruby -*-
# vi: set ft=ruby :

# ==============================================================================
# This Vagrantfile is for testing the plugin. For an example of how to use the
# plugin look at the Vagrantfile in the example directory.
#
# If you are developing or contributing to this plugin you can use this
# Vagrantfile. It is designed to be run inside a Docker container that is
# already on a network called 'devenv'. The Vagrantfile tells Vagrant to start
# the machine on the 'devenv' network, and to give the container's name
# 'vagrant'. While portforwarding to the host for SSH still takes place it is
# ignored and Vagrant connects directly to the SSH port on the 'vagrant'
# container.
#
# Before using this file you'll want to run this command to install vagrant as
# a gem:
#   bundle install
#
# To start vagrant it is important to always use bundle exec:
#   bundle exec vagrant up
#
# To SSH into the container:
#   bundle exec vagrant ssh
#
# To delete the container when finished:
#   bundle exec vagrant destroy -f
#
# ==============================================================================

Vagrant.configure("2") do |config|
  config.vm.provider :docker do |d|
    d.image = "vagrant" # https://github.com/leighmcculloch/vagrant-docker-image
    d.has_ssh = true
    d.create_args = ["--name=vagrant", "--network=devenv"]
  end

  config.ssh.host = "vagrant"
  config.ssh.port = 22

  config.vm.provision :docker_compose, run: "always"
end
