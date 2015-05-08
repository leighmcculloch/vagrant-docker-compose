require "pathname"

require "vagrant-docker-compose/plugin"

module VagrantPlugins
  module DockerComposeProvisioner
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
    end
  end
end
