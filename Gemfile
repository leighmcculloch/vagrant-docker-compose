source "https://rubygems.org"

group :development do
  # Note: v2.2.5 of Vagrant has a bug detailed here: https://github.com/hashicorp/vagrant/pull/10945
  gem "vagrant", git: "https://github.com/mitchellh/vagrant.git", tag: "v2.2.4"
  gem "rake"
end

group :plugins do
  gem "vagrant-docker-compose", path: "."
end
