# -*- encoding: utf-8 -*-

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "vagrant-docker-compose/version"

Gem::Specification.new do |s|
  s.name        = "vagrant-docker-compose"
  s.version     = VagrantPlugins::DockerComposeProvisioner::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Leigh McCulloch"]
  s.homepage    = "https://github.com/leighmcculloch/vagrant-docker-compose"
  s.summary     = %q{A Vagrant provisioner for docker compose.}
  s.description = %q{A Vagrant provisioner for docker compose.}

  s.files        = `git ls-files -z`.split("\0")
  s.require_path = "lib"
end
