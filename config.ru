# Start with: shotgun
# Under Windows: rackup  (CTRL+C and restart on each change)

# class App
#   def call(env)
#     # Return the response array here
#     [
#       200,
#       { "Content-Type" => "text/plain" },
#       [env.inspect] # env["PATH_INFO"]
#     ]
#   end
# end

# run App.new


# run -> env do
#   [200, {}, ["hi"]]
# end


# Routes = {
#   "GET" => {
#     # "path" => block
#   }
# }

# def get(path, &block)
#   Routes["GET"][path] = block
# end

# get "/" do
#   "awesome!"
# end

# get "/hello" do
#   "Hello!"
# end

# run -> env do
#   method = env["REQUEST_METHOD"]
#   path = env["PATH_INFO"]

#   if block = Routes[method][path]
#     body = block.call
#     [200, {}, [body]]
#   else
#     [400, {}, ["Not found"]]
#   end
# end

require ::File.expand_path('../lib/boot', __FILE__)

class Logger
  def initialize(app)
    @app = app # our main Application
  end

  def call(env)
    puts "Calling" + env["PATH_INFO"] # before middleware
    # env["HTTP_COOKIES"] = "..." # We can modify something using middleware
    @app.call(env) # forword to main Application
    # staus, headers, body = @app.call(env)
    # xss_detect(body) # We can using middleware to sanatize body
    # [status, headers, body]
  end
end


use Logger

require "application"
run Application.new