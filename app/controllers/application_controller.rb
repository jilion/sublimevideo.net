class ApplicationController < ActionController::Base

  def logged_in_cookie?
    cookies[:l] == '1'
  end

end
