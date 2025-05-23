# lib/my_framework/controller.rb
require 'erb'

module MyFramework
  class Controller
    def initialize(env)
      @env = env
    end

    def render(template_name)
      template_path = "app/views/#{controller_name}/#{template_name}.erb"
      template = File.read(template_path)
      ERB.new(template).result(binding)
    end

    private

    def controller_name
      self.class.name.gsub(/Controller$/, '').downcase
    end
  end
end