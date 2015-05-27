module VagrantPlugins
  module DockerComposeProvisioner
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :yml, :rebuild, :executable

      def yml=(yml)
        raise DockerComposeError, :yml_must_be_absolute if !Pathname.new(yml).absolute?
        @yml = yml
      end

      def initialize
        @executable = UNSET_VALUE
      end

      def finalize!
        @executable = '/usr/local/bin/docker-compose' if @executable == UNSET_VALUE
      end

    end
  end
end
