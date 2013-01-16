module ApiAuthHelper

  def set_api_auth_token
    @env ||= {}
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials('sublimevideo')
  end

end

RSpec.configuration.include(ApiAuthHelper, type: :request)
