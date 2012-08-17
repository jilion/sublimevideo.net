module Rack
  class Redirect

    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)

      if redirect_url = redirect_url(request)
        [301, { "Location" => redirect_url }, self]
      else
        @app.call(env)
      end
    end

    def each(&block)
    end

  private

    def redirect_url(request)
      case request.path
      when '/demo'
        url(request, 'features')
      when '/signup', '/sign_up', '/register'
        url(request, '?p=signup')
      when '/login', '/log_in', '/sign_in', '/signin'
        url(request, '?p=login')
      when '/javascript-api', '/releases'
        docs_url(request)
      when '/privacy', '/terms', '/sites', '/account'
        my_url(request)
      end
    end

    def url(request, path)
      "#{request.scheme}://#{request.host}/#{path}"
    end

    def docs_url(request)
      "http://docs.#{request.host}#{request.path}"
    end

    def my_url(request)
      "https://my.#{request.host}#{request.path}"
    end

  end
end
