require 'page_constraint'
require 'demo_page_constraint'

SublimeVideo::Application.routes.draw do
  namespace :private_api, constraints: { format: 'json' } do
    resources :tailor_made_player_requests, only: [:index, :show, :destroy] do
      get :topics, on: :collection
    end
  end

  # Legacy redirects
  %w[why horizon-video horizon-framework].each { |action| get action => redirect('/framework') }
  %w[plans pricing modular-player].each { |action| get action => redirect('/features') }
  get 'tailor-made-players' => redirect('/')
  %w[sony twit blackhandcinema next15 html5].each do |showcase|
    get "/tailor-made-players/#{showcase}" => redirect('/')
  end
  get 'customer-showcase' => redirect('/testimonials')
  get 'youtube' => redirect('/demos/player-designs/classic')

  # Shortcut redirects
  %w[demo demos].each { |action| get action => redirect('/demos/player-designs/classic'), as: :"redirect_#{action}" }

  # Docs routes
  %w[javascript-api releases].each do |path|
    get path => redirect { |params, req| "http://docs.#{req.domain}/#{path}" }
  end

  # Stats demo
  %w[stats stats-demo demos/stats].each do |path|
    get path => redirect { |params, req| "https://my.#{req.domain}/stats-demo" }
  end

  # My routes
  %w[signup sign_up register].each do |action|
    get action => redirect { |params, req| "https://my.#{req.domain}/signup" }
  end
  %w[login log_in sign_in signin].each do |action|
    get action => redirect { |params, req| "https://my.#{req.domain}/login" }
  end
  %w[privacy terms sites account].each do |path|
    get path => redirect { |params, req| "https://my.#{req.domain}/#{path}" }
  end

  get '/demos/:feature(/:demo)' => 'demos#show', as: :demo, constraints: DemosConstraint, format: false
  get '/pr/:page' => 'press_releases#show', as: :pr, constraints: PressReleasesConstraint, format: false
  # get '/press-kit' => redirect('http://cl.ly/1x3x2b3J3Z2i/content'), as: :press_kit
  get '/press-kit' => redirect('http://sublimevideo.net'), as: :press_kit

  get '/:page' => 'pages#show', as: :page, constraints: PagesConstraint, format: false

  get '/tailor-made-players-requests/new' => redirect('/')
  # resources :tailor_made_player_requests, only: [:new, :create], path: 'tailor-made-players-requests' do
  #   get :thank_you, on: :collection, path: 'thank-you'
  # end

  root to: 'pages#show', page: 'home', format: :html, via: [:get]
end
