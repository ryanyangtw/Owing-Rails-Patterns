# Applicaation = Class.new do
#  ...  
# end

require "action_controller"
require "application_controller"
require "active_record"
require "router"
require "config/routes"
# require "pry"

# class name is a constant. So it first character should capitalize 
class Application
  def call(env)
    request = Rack::Request.new(env)
    # env["PATH_INFO"] == request.path_info
    response = Rack::Response.new

    controller_name, action_name = route(request.path_info) # /home/index
    # ["home", "index"]

    controller_class = load_controller_class(controller_name) # HomeController
    controller = controller_class.new # HomeController.new
    controller.request = request
    controller.response = response
    controller.process action_name # calls: contoller.index

    # response.write "hi from Application"

    response.finish
    # [200, {}, ["hi from Application"]]
  end

  def route(path)
    # "/home/index" => ["", "home", "index"]

    # _, controller_name, action_name = path.split("/")
    # [controller_name || "home", action_name || "index"]
    Routes.recognize(path)
  end

  def load_controller_class(name)
    # naem = 'home' => HomeController
    require "#{name}_controller" # require "home_controller"
    # We want to look at root of ruby namespace. So we use Object
    Object.const_get name.capitalize + "Controller"  # "HomeController"
  end

end