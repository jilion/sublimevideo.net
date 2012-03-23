require 'spec_helper'

describe PagesController do

  it { get('/').should route_to('pages#show', page: 'home', format: :html) }

  # Rails issue with advanced constraint https://github.com/dchelimsky/rspec-rails/issues/5
  # %w[features plans demo customer-showcase contact].each do |page|
  #   it { get(page).should route_to('pages#show', page: page) }
  # end

end
