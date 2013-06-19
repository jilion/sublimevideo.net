module DemosHelper

  def demo_active_class(feature, demo)
    if request.path == "/demos/#{feature}/#{demo}"
      'demo-sidebar-active'
    end
  end

  def render_demo(file)
    render "#{request.env['PATH_INFO']}/#{file}"
  end

  def render_demo_source(file)
    _render_source "#{request.env['PATH_INFO']}/#{file}"
  end

  private

  def _render_source(*args)
    @html_encoder ||= HTMLEntities.new
    raw(@html_encoder.encode(render(*args)))
  end

end
