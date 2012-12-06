class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_cache_buster, if: -> { Rails.env.development? || Rails.env.test? }

  def logged_in_cookie?
    cookies[:l] == '1'
  end

  private

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
