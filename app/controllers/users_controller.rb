require "user"

class UsersController < ApplicationController
  def index
    # class name also constant in ruby
    # const_missing will be triggered
    User.all.each do |user|
      response.write "<p>#{user.name}</p>"
    end
  end
end