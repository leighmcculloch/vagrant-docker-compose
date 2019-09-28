module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeInstall
          def self.docker_compose_install(machine, config, remote_tmp_path)
            comm = machine.communicate
            comm.sudo("mv #{remote_tmp_path} #{config.executable_install_path}")
            comm.sudo("chmod +x #{config.executable_install_path}")
          end
        end
      end
    end
  end
end
