module VagrantPlugins
  module DockerComposeProvisioner
    class Plugin < Vagrant.plugin("2")
      name "docker-compose-provisioner"
      description <<-DESC
      Provides support for provisioning your virtual machines with Docker-Compose.
      DESC

      I18n.load_path << File.expand_path("../locales/en.yml", __FILE__)
      I18n.reload!

      config(:docker_compose, :provisioner) do
        require_relative "config"
        Config
      end

      guest_capability("linux", "docker_compose_installed") do
        require_relative "cap/linux/docker_compose_installed"
        Cap::Linux::DockerComposeInstalled
      end

      guest_capability("linux", "docker_compose_install") do
        require_relative "cap/linux/docker_compose_install"
        Cap::Linux::DockerComposeInstall
      end

      guest_capability("linux", "docker_compose_set_project_name") do
        require_relative "cap/linux/docker_compose_set_project_name"
        Cap::Linux::DockerComposeSetProjectName
      end

      provisioner(:docker_compose) do
        require_relative "provisioner"
        Provisioner
      end
    end
  end
end
