class EchoController < ApplicationController
  def index
    response.write "You said: " + request["text"]
  end
end

# http://127.0.0.1:9393/echo?text=fuck
