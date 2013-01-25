if ENV['HEROKU_APP']
  require 'autoscaler/sidekiq'
  require 'autoscaler/heroku_scaler'
  heroku = Autoscaler::HerokuScaler.new

  Sidekiq.configure_client do |config|
    config.client_middleware do |chain|
      chain.add Autoscaler::Sidekiq::Client, 'www' => heroku
    end
  end

  Sidekiq.configure_server do |config|
    config.server_middleware do |chain|
      chain.add Autoscaler::Sidekiq::Server, heroku, 30, %w[www]
    end
  end
end
