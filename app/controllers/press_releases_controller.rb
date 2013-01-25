require_dependency 'controller_helpers/cached_page_renderer'

class PressReleasesController < ApplicationController
  include ControllerHelpers::CachedPageRenderer

  def show
    @body_class = 'press_release'
    render_cached_page
  end

end
