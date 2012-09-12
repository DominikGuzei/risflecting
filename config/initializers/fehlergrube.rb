Airbrake.configure do |config|
   config.api_key     = ENV['FEHLERGRUBE_API_KEY']
   config.host        = ENV['FEHLERGRUBE_HOST']
   config.port        = 80
   config.secure      = config.port == 443
end
