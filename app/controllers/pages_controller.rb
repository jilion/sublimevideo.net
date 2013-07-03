class PagesController < ApplicationController
  include CachedPageRendererControllerHelper
  before_filter :handle_help_page, :redirect_to_my

  def show
    @body_class = params[:page]
    render_cached_page
  end

private

  def handle_help_page
    if params[:page] == 'help'
      if logged_in_cookie?
        redirect_to "http://my.#{request.host}/help"
      else # no cache
        @body_class = 'help'
        render 'help'
      end
    end
  end

  def redirect_to_my
    redirect_to "http://my.#{request.host}/#{params[:p]}" if %w[login signup].include?(params[:p])
  end

end
