module VagrantPlugins
  module DockerComposeProvisioner
    module Cap
      module Linux
        module DockerComposeUpload
          def self.docker_compose_upload(machine, config, local_tmp_path)
            comm = machine.communicate

            remote_tmp_path = ""
            comm.execute("mktemp") do |type, data|
              if type == :stdout
                remote_tmp_path << data
              end
            end
            remote_tmp_path.strip!

            comm.upload(local_tmp_path, remote_tmp_path)

            remote_tmp_path
          end
        end
      end
    end
  end
end
