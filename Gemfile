source 'https://rubygems.org'

gem 'rails', '3.2.6'

gem 'pg'
gem 'jquery-rails'

gem 'high_voltage'
gem 'simple-navigation' # navigation for external website
gem 'rails-i18n'

gem 'cancan'
gem 'devise'
gem 'twilio-ruby'
gem 'phony'
gem 'kaminari', '>= 0.13.0'
gem 'rinku', '~> 1.7.0', :require => 'rails_rinku'

gem 'carrierwave'
gem 'rmagick'
gem 'fog'

group :assets do
  gem 'sass', '3.1.20'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
  
  # use custom fork to ensure icons to work in IE8
  gem 'twitter-bootstrap-rails'
end

group :test do
  gem 'rspec', '~> 2.10'
  gem 'rspec-rails'
  gem 'rspec-mocks'

  gem 'cucumber-rails', :require => false
  gem 'launchy' # allows to save and open page in browser during a test
  gem 'poltergeist' # headless browser, requires phantomjs

  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'shoulda-matchers'
  gem 'email_spec'
  gem 'sms-spec'

  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'guard-pow'
  gem 'spork'
end
