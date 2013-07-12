class PressReleasesController < ApplicationController
  include CachedPageRendererControllerHelper

  def show
    render_cached_page
  end

end
