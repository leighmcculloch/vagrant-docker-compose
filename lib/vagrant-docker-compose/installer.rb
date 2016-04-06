module VagrantPlugins
  module DockerComposeProvisioner
    class Installer
      def initialize(machine, config)
        @machine = machine
        @config = config
      end

      def ensure_installed
        @machine.ui.detail(I18n.t(:checking_installation))

        if !@machine.guest.capability(:docker_compose_installed, @config)
          @machine.ui.detail(I18n.t(:installing, version: @config.compose_version))
          @machine.guest.capability(:docker_compose_install, @config)

          if !@machine.guest.capability(:docker_compose_installed, @config)
            raise DockerComposeError, :install_failed
          end
        end

        @machine.ui.detail(I18n.t(:symlinking, version: @config.compose_version))
        @machine.guest.capability(:docker_compose_symlink, @config)

        @machine.guest.capability(:docker_compose_set_project_name, @config)
      end
    end
  end
end
