source 'https://rubygems.org'

gem 'rails', '3.2.3'

gem "mongoid", "~> 2.4"
gem "bson_ext", "~> 1.5"

gem "unicorn"

gem "daemons"
gem "delayed_job"
gem "delayed_job_mongoid"
gem "devise"
gem "haml-rails"
gem "inherited_resources"
gem 'jquery-rails'
gem "newrelic_rpm"
gem "omniauth-facebook"
gem "omniauth-openid"
gem "omniauth-twitter"
gem "rails_config"
gem "simple_form"
gem "redcarpet"

gem "capistrano"
gem "capistrano-ext"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails"
end

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "capybara-webkit"
  gem 'turnip'
  gem 'mongoid-rspec'
  gem "spin"
  gem "guard"
  gem "guard-rspec"
  gem "guard-spin" 
  gem "factory_girl_rails"
  gem 'database_cleaner'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'libnotify'
  gem 'launchy', :require => false
  gem 'timecop'
end

group :development do
  gem 'debugger'
  gem 'letter_opener'
  gem 'thin'
end

group :test, :development do
  gem 'rake'
  gem 'ffaker'
end
