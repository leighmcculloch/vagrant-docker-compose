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

          version = @config.compose_version
          actual_version = version

          # Handle "latest" version
          if version == "latest"
            @machine.ui.detail(I18n.t(:resolving_latest))
            latest_url = "https://github.com/docker/compose/releases/latest"
            actual_version = resolve_latest_version(latest_url)
            @machine.ui.detail(I18n.t(:latest_resolved, version: actual_version))
            # Update the config with the actual version
            @config.instance_variable_set(:@actual_version, actual_version)
            # Set the executable install path with the resolved version
            @config.executable_install_path = "#{@config.executable_symlink_path}-#{actual_version}"
          end

          @machine.ui.detail(I18n.t(:downloading, version: actual_version, kernel: kernel_name, machine: machine_hardware_name))
          url = "https://github.com/docker/compose/releases/download/#{actual_version}/docker-compose-#{kernel_name}-#{machine_hardware_name}"
          remote_tmp_path = nil
          Dir.mktmpdir do |local_tmp_dir|
            local_tmp_path = File.join(local_tmp_dir, "docker-compose")
            File.open(local_tmp_path, "wb") do |f|
              contents = fetch_file(url)
              f.write(contents)
            end
            sig = Digest::SHA256.file(local_tmp_path).hexdigest
            @machine.ui.detail(I18n.t(:downloaded_signature, version: actual_version, signature: sig))

            @machine.ui.detail(I18n.t(:uploading, version: actual_version))
            remote_tmp_path = @machine.guest.capability(:docker_compose_upload, @config, local_tmp_path)
          end

          @machine.ui.detail(I18n.t(:installing, version: actual_version))
          @machine.guest.capability(:docker_compose_install, @config, remote_tmp_path)

          if !@machine.guest.capability(:docker_compose_installed, @config)
            raise DockerComposeError, :install_failed
          end
        end

        # Use the actual version for symlinking if we resolved "latest"
        actual_version = @config.instance_variable_defined?(:@actual_version) ? 
                        @config.instance_variable_get(:@actual_version) : 
                        @config.compose_version

        @machine.ui.detail(I18n.t(:symlinking, version: actual_version))
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

      def resolve_latest_version(url)
        response = Net::HTTP.get_response(URI(url))
        if response.is_a?(Net::HTTPRedirection)
          # Extract version from redirect URL
          # The URL format is something like "https://github.com/docker/compose/releases/tag/1.29.2"
          redirect_url = response['location']
          if redirect_url =~ %r{/releases/tag/(.+)$}
            return $1
          end
        end
        # If we can't determine the version, fall back to a recent known version
        return "1.29.2"  # Fallback to a known version
      end
    end
  end
end
