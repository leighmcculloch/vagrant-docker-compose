module VagrantPlugins
  module DockerComposeProvisioner
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :yml, :rebuild, :project_name, :executable, :compose_version

      def yml=(yml)
        raise DockerComposeError, :yml_must_be_absolute if !Pathname.new(yml).absolute?
        @yml = yml
      end

      def initialize
        @executable = UNSET_VALUE
        @project_name = UNSET_VALUE
        @compose_version = UNSET_VALUE
      end

      def finalize!
        @executable = "/usr/local/bin/docker-compose" if @executable == UNSET_VALUE
        @project_name = nil if @project_name == UNSET_VALUE
        @compose_version = "1.5.0" if @compose_version == UNSET_VALUE
      end
    end
  end
end
