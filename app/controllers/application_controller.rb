class ApplicationController < ActionController::Base
  def hello
    render html: "hello world test for heroku"
  end
end
