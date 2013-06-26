class DemosController < ApplicationController
  include CachedPageRendererControllerHelper

  def show
    @header_class = 'l-mini'
    params[:demo] = Demos.filename_for_path(params[:feature], params[:demo])
    params[:page] = [params[:feature], params[:demo]].join('/')
    render_cached_page
  end

end
