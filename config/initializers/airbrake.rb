Airbrake.configure do |config|
  config.api_key = '486edda8840604c36f90e42e4a50b11a'
  config.ignore  << ActionController::UnknownHttpMethod
end
