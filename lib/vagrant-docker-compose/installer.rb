module VagrantPlugins
  module DockerComposeProvisioner
    class Installer
      def initialize(machine)
        @machine = machine
      end

      def ensure_installed
        @machine.ui.detail(I18n.t(:checking_installation))

        if !@machine.guest.capability(:docker_compose_installed)
          @machine.ui.detail(I18n.t(:installing))
          @machine.guest.capability(:docker_compose_install)

          if !@machine.guest.capability(:docker_compose_installed)
            raise DockerComposeError, :install_failed
          end
        end
      end
    end
  end
end
