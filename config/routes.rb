class PagesConstraint
  def self.matches?(request)
    pages = Dir.glob('app/views/pages/*.html.haml').map { |p|
      p.match(%r(app/views/pages/(.*)\.html\.haml))[1]
    }
    pages.include?(request.params["page"])
  end
end

class PRConstraint
  def self.matches?(request)
    pages = Dir.glob('app/views/press_releases/*.html.haml').map { |p|
      p.match(%r(app/views/press_releases/(.*)\.html\.haml))[1]
    }
    pages.include?(request.params["page"])
  end
end

SublimeVideo::Application.routes.draw do
  # Redirects
  %w[demo features].each { |action| get action => redirect('/modular-player') }
  %w[signup sign_up register].each { |action| get action => redirect('/?p=signup') }
  %w[login log_in sign_in signin].each { |action| get action => redirect('/?p=login') }
  get 'plans' => redirect('/pricing')
  get 'customer-showcase' => redirect('/testimonials')

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

  get '/pr/:page' => 'press_releases#show', as: :pr, constraints: PRConstraint, format: false
  get '/press-kit' => redirect('http://cl.ly/433P3t1P2a1m202w2Y3D/content'), as: :press_kit

  get '/:page' => 'pages#show', as: :page, constraints: PagesConstraint, format: false

  resources :tailor_made_player_requests, only: [:new, :create], path: 'tailor-made-players-requests' do
    get :thank_you, on: :collection, path: 'thank-you'
  end

  root to: 'pages#show', page: 'home', format: :html
end
