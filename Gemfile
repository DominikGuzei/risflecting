source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.21'

gem 'pg'
gem 'jquery-rails'

gem 'high_voltage'
gem 'simple-navigation' # navigation for external website
gem 'rails-i18n'

gem 'cancan'
gem 'devise'
gem 'phony'
gem 'kaminari', '>= 0.13.0'
gem 'rinku', '~> 1.7.0', :require => 'rails_rinku'

gem 'carrierwave', '~> 0.6.2'
gem 'rmagick'
gem 'fog', '~> 1.5.0'

gem 'airbrake'
gem 'sentry-raven'
gem 'skylight'

group :assets do
  gem 'sass', '3.1.20'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'

  # use custom fork to ensure icons to work in IE8
  gem 'twitter-bootstrap-rails', :git => 'https://github.com/tombu/twitter-bootstrap-rails.git', :branch => 'bug/fix-fontawesome-font-declaration'
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
  gem 'shoulda-matchers', '1.3.0'
  gem 'email_spec'

  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'guard-pow'
  gem 'spork'
end
