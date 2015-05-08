module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeInstall
          def self.docker_compose_install(machine)
            machine.communicate.tap do |comm|
              comm.sudo("curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose")
            end
          end
        end
      end
    end
  end
end
