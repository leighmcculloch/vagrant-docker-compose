require "pathname"

module VagrantPlugins
  module DockerComposeProvisioner
    class DockerCompose
      def initialize(machine, config)
        @machine = machine
        @config = config
      end

      def build
        @machine.ui.detail(I18n.t(:docker_compose_build))
        @machine.communicate.tap do |comm|
          comm.sudo("#{@config.executable} #{@config.options} -f \"#{@config.yml}\" build #{@config.command_options[:build]}") do |type, data|
            handle_comm(type, data)
          end
        end
      end

      def rm
        @machine.ui.detail(I18n.t(:docker_compose_rm))
        @machine.communicate.tap do |comm|
          comm.sudo("#{@config.executable} #{@config.options} -f \"#{@config.yml}\" rm #{@config.command_options[:rm]}") do |type, data|
            handle_comm(type, data)
          end
        end
      end

      def up
        @machine.ui.detail(I18n.t(:docker_compose_up))
        @machine.communicate.tap do |comm|
          comm.sudo("#{@config.executable} #{@config.options} -f \"#{@config.yml}\" up #{@config.command_options[:up]}") do |type, data|
            handle_comm(type, data)
          end
        end
      end

      protected

      def handle_comm(type, data)
        data.chomp!
        return if data.empty?
        case type
        when :stdout; @machine.ui.detail(data)
        when :stderr; @machine.ui.error(data)
        end
      end
    end
  end
end
