module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeInstall
          def self.docker_compose_install(machine, config)
            machine.communicate.tap do |comm|
              comm.sudo("curl -L https://github.com/docker/compose/releases/download/#{config.compose_version}/docker-compose-`uname -s`-`uname -m` > #{config.executable}
  chmod +x #{config.executable}")
            end
          end
        end
      end
    end
  end
end
