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
          comm.sudo("#{@config.env_s} #{@config.executable_install_path} #{@config.options} #{cli_options_for_yml_file} build #{@config.command_options[:build]}") do |type, data|
            handle_comm(type, data)
          end
        end
      end

      def rm
        @machine.ui.detail(I18n.t(:docker_compose_rm))
        @machine.communicate.tap do |comm|
          comm.sudo("#{@config.env_s} #{@config.executable_install_path} #{@config.options} #{cli_options_for_yml_file} rm #{@config.command_options[:rm]}") do |type, data|
            handle_comm(type, data)
          end
        end
      end

      def up
        @machine.ui.detail(I18n.t(:docker_compose_up))
        @machine.communicate.tap do |comm|
          comm.sudo("#{@config.env_s} #{@config.executable_install_path} #{@config.options} #{cli_options_for_yml_file} up #{@config.command_options[:up]}") do |type, data|
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

      private

      def cli_options_for_yml_file
        files = @config.yml.is_a?(Array) ? @config.yml : [@config.yml]
        files.map { |file| "-f \"#{file}\"" }.join(" ")
      end
    end
  end
end
