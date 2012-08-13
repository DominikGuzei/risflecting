source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'pg'
gem 'jquery-rails'
gem 'high_voltage'
gem 'rails-i18n'

gem 'cancan'
gem 'devise'
gem 'twilio-ruby'

group :assets do
  gem 'sass', '3.1.20'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'

  # limit version to ensure that phantomjs works
  # see https://github.com/jonleighton/poltergeist/issues/44
  gem 'twitter-bootstrap-rails', '2.0.8'
end

group :development, :test do
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

  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'guard-pow'
  gem 'spork'
end

group :test do
  gem 'sms-spec'
end

