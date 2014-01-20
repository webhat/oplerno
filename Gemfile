source 'https://rubygems.org'
source 'https://rails-assets.org'

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'libnotify', :require => RUBY_PLATFORM.include?('linux') && 'rb-inotify'
gem 'growl', :require => RUBY_PLATFORM.include?('darwin') && 'growl'

gem 'rails', '3.2.14'
gem "jquery-rails", "< 3.0.0"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  gem 'sdoc', require: false
  gem 'yard', require: false
  gem 'guard-yard'
  gem 'guard-jasmine'
  gem 'guard-coffeescript'
	gem 'guard-cucumber'
  gem 'redcarpet'

# metrics
	gem 'reek'
	gem 'metric_fu'
	gem 'simplecov-rcov-text'
	gem 'churn'
	gem 'flog'
end


gem 'activeadmin'
gem 'activemerchant'
gem 'devise'
gem 'devise-i18n'
gem 'devise-authy'
gem 'mysql2'
gem 'sqlite3'
gem 'ruby-saml'
gem 'ruby-saml-idp'
gem 'newrelic_rpm'
gem 'coveralls', require: false

gem 'canvas-api'

gem 'json'
gem 'strongbox'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'rails-assets-jquery-ui'
end

group :development do
  gem 'quiet_assets'
  gem 'thin'

  gem 'rb-fsevent', '~> 0.9.4', :require => false
  gem 'rb-inotify', '~> 0.9.3', :require => false
  gem 'rb-fchange', :require => false
end

gem 'minitest', '~> 4.0'
gem 'minitest-rails'
group :development, :test do
  gem 'minitest-rails-capybara'
  gem 'minitest-colorize'
  gem 'minitest-focus'

  gem 'minitest-reporters'
  gem 'rspec-rails'
  gem 'rspec-expectations'
  gem 'rspec-mocks'
  gem 'simplecov'
  gem 'factory_girl_rails'
	gem 'jasmine'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'poltergeist'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
  gem 'cucumber-rails', :require => false
  gem 'cucumber'
  gem 'database_cleaner'
	gem 'perftools.rb'
  gem 'rack-perftools_profiler', :require => 'rack/perftools_profiler'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'sshkit', group: :development
gem 'capistrano', group: :development
gem 'bundler'
gem 'capistrano-bundler', group: :development
#gem 'capistrano-rvm', group: :development
gem 'capistrano-rails', group: :development
gem 'rvm1-capistrano3', group: :development, :require => false

gem 'unicorn' #, group: :production

# Use debugger
# gem 'debugger', group: [:development, :test]
# gem 'ruby-debug19', :require => 'ruby-debug'

