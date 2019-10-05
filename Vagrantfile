# -*- mode: ruby -*-
# vi: set ft=ruby :

# ==============================================================================
#
# This Vagrantfile is for developing and testing the plugin. For an example of
# how to use the plugin look at the Vagrantfile in the example directory.
#
# ==============================================================================
#
# If you are developing or contributing to this plugin you can use this
# Vagrantfile. It supports being run automatically in two configurations:
#
# 1) Outside Docker, using Vagrant running on a host.
#
# 2) Inside a Docker container that has access to the Docker socket and attached
#    to a network named 'devenv'. Run the following commands inside the Docker
#    container.
#
# In both configurations you can start it up with:
#
#      bundle install
#      bundle exec vagrant up
#
# All vagrant commands need to be prefixed with 'bundle exec'.
#
# ==============================================================================

def inside_docker?
  system("grep docker /proc/1/cgroup -qa")
end

Vagrant.configure("2") do |config|
  inside_docker = inside_docker?

  config.vm.provider :docker do |d|
    d.image = "vagrant" # https://github.com/leighmcculloch/vagrant-docker-image
    d.has_ssh = true
    d.create_args = [
      "--name=vagrant",
      ("--network=devenv" if inside_docker),
    ].compact
  end

  if inside_docker
    config.ssh.host = "vagrant"
    config.ssh.port = 22
  end

  config.vm.provision :docker_compose, run: "always"
end
