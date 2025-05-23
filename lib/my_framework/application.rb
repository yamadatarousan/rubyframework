# lib/my_framework/application.rb
require 'webrick'

module MyFramework
    class Application
      class << self
        def call(env)
          # コントローラーをロード
          load_controllers
          
          # ルーティング設定を読み込む
          router = nil
          routes_file = File.join(Dir.pwd, 'config/routes.rb')
          
          if File.exist?(routes_file)
            router = eval(File.read(routes_file))
          else
            router = Router.new
          end
    
          controller_class, action = router.match(env)
    
          if controller_class && action
            controller = controller_class.new(env)
            response = controller.send(action)
            [200, { 'content-type' => 'text/html' }, [response]]
          else
            [404, { 'content-type' => 'text/plain' }, ['Not Found']]
          end
        end
        
        private
        
        def load_controllers
          controllers_dir = File.join(Dir.pwd, 'app/controllers')
          if Dir.exist?(controllers_dir)
            Dir.glob(File.join(controllers_dir, '*.rb')).each do |file|
              require file
            end
          end
        end
      end
    end
  end