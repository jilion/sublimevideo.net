module DemosHelper

  def demo_active_class(feature, demo)
    if request.path == "/demos/#{feature}/#{demo}"
      'demo-sidebar-active'
    end
  end

end
