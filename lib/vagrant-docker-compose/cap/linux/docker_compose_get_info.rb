module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeGetInfo
          def self.docker_compose_get_info(machine, config)
            comm = machine.communicate

            kernel_name = ""
            comm.execute("uname -s") do |type, data|
              if type == :stdout
                kernel_name << data
              end
            end
            kernel_name.strip!

            machine_hardware_name = ""
            comm.execute("uname -m") do |type, data|
              if type == :stdout
                machine_hardware_name << data
              end
            end
            machine_hardware_name.strip!

            [machine_hardware_name, kernel_name]
          end
        end
      end
    end
  end
end
