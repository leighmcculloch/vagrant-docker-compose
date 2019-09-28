# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-docker-compose")
  system("vagrant plugin install vagrant-docker-compose")
  puts "Dependencies installed, please try the command again."
  exit
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  port = 9090

  config.vm.network(:forwarded_port, guest: port, host: port)
  config.vm.network(:forwarded_port, guest: 3333, host: 3333)

  config.vm.provision :shell, inline: "apt-get update"
  config.vm.provision :docker
  config.vm.provision :docker_compose, env: { "PORT" => "#{port}" }, yml: ["/vagrant/docker-compose-base.yml","/vagrant/docker-compose.yml"], rebuild: true, project_name: "myproject", run: "always"
end
