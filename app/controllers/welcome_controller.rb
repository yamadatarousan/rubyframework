# app/controllers/welcome_controller.rb
require_relative '../../lib/my_framework/controller'

class WelcomeController < MyFramework::Controller
  def index
    @message = 'Hello, My Framework!'
    render :index
  end
end