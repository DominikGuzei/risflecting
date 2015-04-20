Raven.configure do |config|
  config.dsn = ENV.fetch('SENTRY_PRIVATE_DSN')
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = %w( staging production )
  config.tags = { environment: Rails.env }
end
