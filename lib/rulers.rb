require "rulers/version"
require 'rulers/routing'

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return[404, {'Content-Type' => 'text/html'}, []]
      elsif env['PATH_INFO' == '/']
        cont, action = 'quotes', 'a_quote'
        cont = cont.capitalize
        cont += "Controller"
        klass, act = Object.cont_get(cont), action
        controller = klass.new(env)
        text = controller.send(act)
        [200, {'Content-Type' => 'text/html'},
        [text]]

      else  
        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(act)
        [200, {'Content-Type' => 'text/html'},
        [text]]
      end
    end
  end
  
  class Controller
    def initialize(env)
      @env = env
    end
    def env
      @env 
    end  
  end
end

