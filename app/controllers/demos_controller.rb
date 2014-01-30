class DemosController < ApplicationController
  include CachedPageRendererControllerHelper

  before_filter do
    @header_class  = 'l-mini'
    @page_category = 'Demo'
    @global_layout = 'two_col'
  end

  def show
    redirect_to demo_path(params[:feature], Demos.paths_for(params[:feature]).first) and return unless params[:demo]

    params[:demo] = Demos.filename_for_path(params[:feature], params[:demo])
    params[:page] = [params[:feature], params[:demo]].join('/')
    render_cached_page
  end

end
