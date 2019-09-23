module VagrantPlugins
  module DockerComposeProvisioner
    class Config < Vagrant.plugin("2", :config)
      DEFAULT_COMMAND_OPTIONS = {
        rm: "--force",
        up: "-d"
      }

      attr_accessor :yml, :rebuild, :project_name, :env, :executable_symlink_path, :executable_install_path, :compose_version, :options, :command_options

      def yml=(yml)
        files = yml.is_a?(Array) ? yml : [yml]
        files.each do |file|
          raise DockerComposeError, :yml_must_be_absolute if !Pathname.new(file).absolute?
        end
        @yml = yml
      end

      def initialize
        @project_name = UNSET_VALUE
        @compose_version = UNSET_VALUE
        @env = UNSET_VALUE
        @executable_symlink_path = UNSET_VALUE
        @executable_install_path = UNSET_VALUE
        @options = UNSET_VALUE
        @command_options = UNSET_VALUE
      end

      def finalize!
        @project_name = nil if @project_name == UNSET_VALUE
        @compose_version = "1.24.1" if @compose_version == UNSET_VALUE
        @env = {} if @env == UNSET_VALUE
        @executable_symlink_path = "/usr/local/bin/docker-compose" if @executable_symlink_path == UNSET_VALUE
        @executable_install_path = "#{@executable_symlink_path}-#{@compose_version}" if @executable_install_path == UNSET_VALUE
        @options = nil if @options == UNSET_VALUE
        @command_options = {} if @command_options == UNSET_VALUE
        @command_options = DEFAULT_COMMAND_OPTIONS.merge(@command_options)
      end

      def env_s
        @env.map { |k, v| "#{k}=#{Shellwords.escape(v)}" }.join(" ")
      end
    end
  end
end
