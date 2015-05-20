require_relative "errors/docker_compose_error"
require_relative "installer"
require_relative "docker_compose"

module VagrantPlugins
  module DockerComposeProvisioner
    class Provisioner < Vagrant.plugin("2", :provisioner)
      def initialize(machine, config, installer = nil, docker_compose = nil)
        super(machine, config)

        @installer = installer || Installer.new(@machine, @config)
        @docker_compose = docker_compose || DockerCompose.new(@machine, @config)
      end

      def provision
        @installer.ensure_installed

        return unless @config.yml

        if @config.rebuild
          @docker_compose.rm
          @docker_compose.build
        end

        @docker_compose.up
      end
    end
  end
end
