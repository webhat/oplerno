source 'https://rubygems.org'
source 'https://rails-assets.org'

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

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
	gem 'guard-compass'
#gem 'guard-jslint-on-rails'
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

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'rails-assets-jquery-ui'
end

group :development do
  gem 'quiet_assets'
  gem 'thin'
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
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'sshkit', '~> 1.0.0', group: :development
gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
# gem 'ruby-debug19', :require => 'ruby-debug'

