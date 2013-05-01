module FeaturesHelper

  def feature(feature, opts = {})
    options = { demo: true, learn_more_url: nil }.merge(opts)

    render 'features/feature', feature: feature, demo: options[:demo], learn_more_url: options[:learn_more_url]
  end

end
