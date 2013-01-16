require_dependency 'responders/kaminari_api_responder'

class Api::ApiController < ActionController::Base
  respond_to :json
  before_filter :authenticate
  responders Responders::KaminariApiResponder

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == ENV['API_PASSWORD'] || 'sublimevideo'
    end
  end

end
