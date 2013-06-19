class DemosController < ApplicationController
  include CachedPageRendererControllerHelper

  def show
    @header_class = 'l-mini'
    params[:page] = [params[:feature], params[:demo]].join('/')
    render_cached_page
  end

end
