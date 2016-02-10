class HomeController < ApplicationController
  # HomeController.before_action
  # self.before_action
  before_action :header

  def index
    response.write "hi from HomeController"
  end

  def header
    response.write "<h1>My App</h1>"
  end
end