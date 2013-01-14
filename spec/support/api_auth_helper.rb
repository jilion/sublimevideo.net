module ApiAuthHelper

  def http_api_login
    @env ||= {}
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
      'sublimevideo','sublimevideo')
  end

end

RSpec.configuration.include(ApiAuthHelper, type: :request)
