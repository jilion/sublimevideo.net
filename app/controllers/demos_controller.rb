class DemosController < ApplicationController
  include CachedPageRendererControllerHelper

  def show
    params[:page] = [params[:feature], params[:demo]].join('/')
    render_cached_page
  end

end
