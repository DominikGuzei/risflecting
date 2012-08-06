source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'pg'

gem 'high_voltage'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'

  # limit version to ensure that phantomjs works
  # see https://github.com/jonleighton/poltergeist/issues/44
  gem 'twitter-bootstrap-rails', '2.0.8'
end

gem 'jquery-rails'

group :development, :test do
  gem 'rspec', '~> 2.10'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner' # needed for cucumber
end

