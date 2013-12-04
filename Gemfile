source 'https://rubygems.org'

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'rails', '3.2.14'
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  gem 'sdoc', require: false
end


gem 'activeadmin'
gem 'devise'
gem 'devise-authy'
gem 'mysql2'
gem 'sqlite3'
gem 'ruby-saml'
gem 'ruby-saml-idp'
gem 'newrelic_rpm'

gem 'json'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
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
  gem 'simplecov'
end

group :development, :test do
  gem 'rspec-rails'
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
  gem 'launchy'
  gem 'vcr'
  gem 'fakeweb'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
# gem 'ruby-debug19', :require => 'ruby-debug'
