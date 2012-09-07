Airbrake.configure do |config|
   config.api_key     = 'af0ca3e11eae1271d0cd7e2868f07803'
   config.host        = 'fehlergrube.herokuapp.com'
   config.port        = 80
   config.secure      = config.port == 443
end
