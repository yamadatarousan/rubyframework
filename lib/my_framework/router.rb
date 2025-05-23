# lib/my_framework/router.rb
module MyFramework
    class Router
      def initialize
        @routes = []
      end
  
      def self.draw(&block)
        router = new
        router.instance_eval(&block)
        router
      end
  
      def get(path, to:)
        @routes << { method: 'GET', path: path, controller: to }
      end
  
      def match(env)
        request_method = env['REQUEST_METHOD']
        path = env['PATH_INFO']
  
        route = @routes.find do |r|
          r[:method] == request_method && r[:path] == path
        end
  
        route ? parse_controller(route[:controller]) : nil
      end
  
      private
  
      def parse_controller(controller_action)
        controller_name, action = controller_action.split('#')
        controller_class = Object.const_get("#{controller_name.capitalize}Controller")
        [controller_class, action]
      end
    end
  end