CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                         # required
    :aws_access_key_id      => ENV['S3_ACCESS_KEY_ID'],       # required
    :aws_secret_access_key  => ENV['S3_SECRET_ACCESS_KEY'],   # required
    :region                 => 'eu-west-1'                      # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'risflecting'                       # required
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.storage = :fog
end

if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
