class HomeController < ApplicationController
  # HomeController.before_action
  # self.before_action
  before_action :header
  after_action :footer

  def index
    # response.write "hi from HomeController"
    @message = "This is message"
    render :index
  end

  def header
    response.write "<h1>My App</h1>"
  end

  def footer
    response.write "<p>&copy; me</p>"
  end
end