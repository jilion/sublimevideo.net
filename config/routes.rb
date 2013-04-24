class PagesConstraint < PageConstraint; end
class PressReleasesConstraint < PageConstraint; end

SublimeVideo::Application.routes.draw do
  namespace :private_api do
    resources :tailor_made_player_requests, only: [:index, :show, :destroy] do
      get :topics, on: :collection
    end
  end

  # Redirects
  %w[demo modular-player].each { |action| get action => redirect('/features') }
  %w[signup sign_up register].each { |action| get action => redirect('/?p=signup') }
  %w[login log_in sign_in signin].each { |action| get action => redirect('/?p=login') }
  get 'why' => redirect('/horizon-framework')
  get 'plans' => redirect('/pricing')
  get 'customer-showcase' => redirect('/testimonials')
  get 'horizon-video' => redirect('/#horizon-video')

  # Docs routes
  %w[javascript-api releases].each do |path|
    get path => redirect { |params, req| "http://docs.#{req.domain}/#{path}" }
  end

  # Stats demo
  %w[stats stats-demo].each do |path|
    get path => redirect { |params, req| "#{req.scheme}://my.#{req.domain}/stats-demo" }
  end

  # My routes
  %w[privacy terms sites account].each do |path|
    get path => redirect { |params, req| "#{req.scheme}://my.#{req.domain}/#{path}" }
  end

  # Showcase redirects
  %w[sony twit blackhandcinema next15 html5].each do |showcase|
    get "/tailor-made-players/#{showcase}" => redirect { |params, req| "/tailor-made-players##{showcase}" }
  end

  get '/pr/:page' => 'press_releases#show', as: :pr, constraints: PressReleasesConstraint, format: false
  get '/press-kit' => redirect('http://cl.ly/1x3x2b3J3Z2i/content'), as: :press_kit

  get '/:page' => 'pages#show', as: :page, constraints: PagesConstraint, format: false

  resources :tailor_made_player_requests, only: [:new, :create], path: 'tailor-made-players-requests' do
    get :thank_you, on: :collection, path: 'thank-you'
  end

  root to: 'pages#show', page: 'home', format: :html
end
