module UrlsHelper

  def demo_site_stats_url
    my_url('sites/stats/demo')
  end

  # lame hack until sublimevideo_layout 0.6.6 is released...
  def sublimevideo_include_tag(ssl_request, name)
    %(<script src="#{ssl_request ? "https://4076.voxcdn.com" : "http://cdn.sublimevideo.net"}/js/#{::SiteToken[name.to_sym]}.js" type="text/javascript"></script>)
  end

end
