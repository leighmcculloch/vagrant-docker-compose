module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeInstalled
          def self.docker_compose_installed(machine)
            paths = [
              "/usr/local/bin/docker-compose"
            ]

            paths.all? do |p|
              machine.communicate.test("test -f #{p}", sudo: true)
            end
          end
        end
      end
    end
  end
end
