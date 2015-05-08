module VagrantPlugins
  module DockerComposeProvisioner
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :yml, :rebuild

      def yml=(yml)
        raise DockerComposeError, :yml_must_be_absolute if !Pathname.new(yml).absolute?
        @yml = yml
      end
    end
  end
end
