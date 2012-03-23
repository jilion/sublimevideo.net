module UrlsHelper
  
  def demo_site_stats_url
    "#{https_if_prod_or_staging}://my.#{request.domain}/sites/stats/demo"
  end
  
  def https_if_prod_or_staging
    Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
  end

  
end
