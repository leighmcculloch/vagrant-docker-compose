module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeSymlink
          def self.docker_compose_symlink(machine, config)
            machine.communicate.tap do |comm|
              comm.sudo("rm -f #{config.executable_symlink_path}")
              comm.sudo("ln -s #{config.executable_install_path} #{config.executable_symlink_path}")
            end
          end
        end
      end
    end
  end
end
