require_dependency 'responders/kaminari_api_responder'

class Api::ApiController < ActionController::Base
  http_basic_authenticate_with(
    name: 'sublimevideo',
    password: ENV['API_PASSWORD'] || 'sublimevideo')

  respond_to :json

  responders Responders::KaminariApiResponder
end
