class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in_cookie?
    cookies[:l] == '1'
  end

end
