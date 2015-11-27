module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeSetProjectName
          ROOT_PROFILE_FILE_NAME = "~/.profile"
          PROFILE_FILE_NAME = "~/.profile_vagrant-docker-compose_compose-project-name"

          def self.docker_compose_set_project_name(machine, config)
            return if config.project_name.nil?
            machine.communicate.tap do |comm|
              export_command = "export COMPOSE_PROJECT_NAME='#{config.project_name}'"
              export_injection_command = "echo \"#{export_command}\" > #{PROFILE_FILE_NAME}"
              comm.execute(export_injection_command)
              comm.sudo(export_injection_command)

              source_command = "source #{PROFILE_FILE_NAME}"
              source_injection_command = "if ! grep -q \"#{source_command}\" #{ROOT_PROFILE_FILE_NAME} ; then echo \"#{source_command}\" >> #{ROOT_PROFILE_FILE_NAME} ; fi"
              comm.execute(source_injection_command)
              comm.sudo(source_injection_command)
            end
          end
        end
      end
    end
  end
end
