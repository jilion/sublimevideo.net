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
    p pages
    pages.include?(request.params["page"])
  end
end

SublimeVideo::Application.routes.draw do
  # Please also check Rack::Redirect middleware in lib/rack

  get '/pr/:page' => 'press_releases#show', as: :pr, constraints: PRConstraint, format: false
  get '/press-kit' => redirect('http://cl.ly/433P3t1P2a1m202w2Y3D/content'), as: :press_kit

  get '/:page' => 'pages#show', as: :page, constraints: PagesConstraint, format: false

  root to: 'pages#show', page: 'home', format: :html
end
