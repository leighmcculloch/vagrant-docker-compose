module VagrantPlugins
  module DockerComposeProvisioner
    class Config < Vagrant.plugin("2", :config)
      DEFAULT_COMMAND_OPTIONS = {
        rm: "--force",
        up: "-d"
      }

      attr_accessor :yml, :rebuild, :project_name, :executable, :compose_version, :options, :command_options

      def yml=(yml)
        files = yml.is_a?(Array) ? yml : [yml]
        files.each do |file|
          raise DockerComposeError, :yml_must_be_absolute if !Pathname.new(file).absolute?
        end
        @yml = yml
      end

      def initialize
        @executable = UNSET_VALUE
        @project_name = UNSET_VALUE
        @compose_version = UNSET_VALUE
        @options = UNSET_VALUE
        @command_options = UNSET_VALUE
      end

      def finalize!
        @executable = "/usr/local/bin/docker-compose" if @executable == UNSET_VALUE
        @project_name = nil if @project_name == UNSET_VALUE
        @compose_version = "1.5.0" if @compose_version == UNSET_VALUE
        @options = nil if @options == UNSET_VALUE
        @command_options = {} if @command_options == UNSET_VALUE
        @command_options = DEFAULT_COMMAND_OPTIONS.merge(@command_options)
      end
    end
  end
end
