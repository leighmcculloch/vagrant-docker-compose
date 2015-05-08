module VagrantPlugins
  module DockerComposeProvisioner
    class DockerComposeError < Vagrant::Errors::VagrantError
      error_namespace("errors")
    end
  end
end
