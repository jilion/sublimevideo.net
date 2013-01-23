require_dependency 'configurator'

module S3Config
  include Configurator

  config_file 's3.yml'
  config_accessor :access_key_id, :secret_access_key
end
