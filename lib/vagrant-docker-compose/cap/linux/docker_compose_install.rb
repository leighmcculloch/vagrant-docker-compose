module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeInstall
          def self.docker_compose_install(machine, config)
            machine.communicate.tap do |comm|
              comm.sudo("curl -L https://github.com/docker/compose/releases/download/#{config.compose_version}/docker-compose-`uname -s`-`uname -m` > #{config.executable_install_path}")
              comm.sudo("chmod +x #{config.executable_install_path}")
            end
          end
        end
      end
    end
  end
end
