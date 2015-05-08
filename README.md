# Vagrant Provisioner: Docker Compose

A Vagrant provisioner for [Docker Compose](https://docs.docker.com/compose/). Installs Docker Compose and can also bring up the containers defined by a [docker-compose.yml](https://docs.docker.com/compose/yml/).

## Install

```bash
vagrant plugin install vagrant-docker-compose
```

## Usage

### To install docker and docker-compose

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :docker
  config.vm.provision :docker_compose
end
```

### To install and run docker-compose on `vagrant up`

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yml", run: "always"
end
```

Equivalent to running:

```bash
docker-compose -f [yml] up
```

### To install, rebuild and run docker-compose on `vagrant up`

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yml", rebuild: true, run: "always"
end
```

Equivalent to running:

```bash
docker-compose -f [yml] rm
docker-compose -f [yml] build
docker-compose -f [yml] up
```

## Example

See `example` in the repository for a full working example.