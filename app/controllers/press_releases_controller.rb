class PressReleasesController < ApplicationController
  include CachedPageRendererControllerHelper

  def show
    @body_class = 'press_release'
    render_cached_page
  end

end
