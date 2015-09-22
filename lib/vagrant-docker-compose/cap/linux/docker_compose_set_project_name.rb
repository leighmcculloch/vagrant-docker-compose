module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeSetProjectName
          def self.docker_compose_set_project_name(machine, config)
            return if config.project_name.nil?
            machine.communicate.tap do |comm|
              export_command = "if grep -q \"COMPOSE_PROJECT_NAME\" ~/.profile;then :; else echo \"export
COMPOSE_PROJECT_NAME='#{config.project_name}'\" >> ~/.profile;fi"
              comm.execute(export_command)
              comm.sudo(export_command)
            end
          end
        end
      end
    end
  end
end
