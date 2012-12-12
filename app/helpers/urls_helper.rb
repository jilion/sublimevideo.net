module UrlsHelper

  def cdn_host
    case Rails.env
    when 'production'
      'cdn.sublimevideo.net'
    else
      'cdn.sublimevideo-staging.net'
    end
  end

  def demo_site_stats_url
    my_url('stats-demo')
  end

  def get_satisfaction_next_features_discussion_url
    'https://getsatisfaction.com/sublimevideo'
  end

  def get_satisfaction_opening_horizon_to_developers_url
    'https://getsatisfaction.com/sublimevideo'
  end

end
