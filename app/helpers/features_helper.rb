module FeaturesHelper

  def feature(feature, opts = {})
    options = { feature: feature, demo: true, learn_more_url: nil, add_ons: '' }.merge(opts)

    render 'features/feature', options
  end

  def add_on(feature, opts = {})
    feature(feature, opts.merge(add_ons: render('features/add_ons', add_on_category: feature, add_ons: opts.delete(:add_ons))))
  end

  def display_amount_with_sup(amount_in_cents)
    units = amount_in_cents.to_i / 100
    decimals = amount_in_cents.to_i - (units * 100)
    "#{number_to_currency(units, precision: 0)}#{content_tag(:sup, ".#{decimals}") unless decimals.zero?}".html_safe
  end

end
