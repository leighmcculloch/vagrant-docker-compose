module VagrantPlugins
  module DockerComposeProvisioner
    class Installer
      def initialize(machine, config)
        @machine = machine
        @config = config
      end

      def ensure_installed
        @machine.ui.detail(I18n.t(:checking_installation))

        if !@machine.guest.capability(:docker_compose_installed, @config)
          @machine.ui.detail(I18n.t(:getting_info))
          machine_hardware_name, kernel_name = @machine.guest.capability(:docker_compose_get_info, @config)

          @machine.ui.detail(I18n.t(:downloading, version: @config.compose_version, kernel: kernel_name, machine: machine_hardware_name))
          url = "https://github.com/docker/compose/releases/download/#{@config.compose_version}/docker-compose-#{kernel_name}-#{machine_hardware_name}"
          remote_tmp_path = nil
          Dir.mktmpdir do |local_tmp_dir|
            local_tmp_path = File.join(local_tmp_dir, "docker-compose")
            File.open(local_tmp_path, "wb") do |f|
              contents = fetch_file(url)
              f.write(contents)
            end
            sig = Digest::SHA256.file(local_tmp_path).hexdigest
            @machine.ui.detail(I18n.t(:downloaded_signature, version: @config.compose_version, signature: sig))

            @machine.ui.detail(I18n.t(:uploading, version: @config.compose_version))
            remote_tmp_path = @machine.guest.capability(:docker_compose_upload, @config, local_tmp_path)
          end

          @machine.ui.detail(I18n.t(:installing, version: @config.compose_version))
          @machine.guest.capability(:docker_compose_install, @config, remote_tmp_path)

          if !@machine.guest.capability(:docker_compose_installed, @config)
            raise DockerComposeError, :install_failed
          end
        end

        @machine.ui.detail(I18n.t(:symlinking, version: @config.compose_version))
        @machine.guest.capability(:docker_compose_symlink, @config)

        @machine.guest.capability(:docker_compose_set_project_name, @config)
      end

      def fetch_file(url)
        response = Net::HTTP.get_response(URI(url))
        case response
        when Net::HTTPSuccess then
          return response.body
        when Net::HTTPRedirection then
          new_url = response['location']
          return fetch_file(new_url)
        else
          raise "Error: unable to download docker-compose: #{url}"
        end
      end
    end
  end
end
