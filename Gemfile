source 'https://rubygems.org'
source 'https://rails-assets.org'
# ruby '2.0.0'

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'libnotify', require: RUBY_PLATFORM.include?('linux') && 'rb-inotify'
gem 'growl', require: RUBY_PLATFORM.include?('darwin') && 'growl'

gem 'rails', '~> 3.2.21'
gem 'jquery-rails', '< 3.0.0'
gem 'actionpack', '~> 3.2.21'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '>= 2.2.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0.5'
gem 'jpbuilder'

group :doc do
  gem 'sdoc', require: false
  gem 'yard', require: false
  gem 'guard-rspec'
  gem 'guard-yard'
  gem 'guard-jasmine', '~> 2.0.1'
  gem 'guard-coffeescript', github: 'guard/guard-coffeescript'
  gem 'guard-cucumber', '~> 1.5.0'
  gem 'guard-rubocop'
  gem 'brakeman', '~> 2.6.3'
  gem 'guard-brakeman', '~> 0.8.2'
  gem 'redcarpet'

  # metrics
  # FIXME: What's wrong here?
  gem 'reek', require: false
  gem 'metric_fu', require: false
  gem 'churn', require: false
  gem 'flog', require: false
  gem 'simplecov-rcov-text', require: false
  gem 'cadre', require: false
end

gem 'activeadmin', '>= 0.6.3'
gem 'paper_trail'
gem 'paranoia', '~> 1.0'
gem 'activemerchant', '>= 1.42.7'
gem 'devise', '>= 3.2.4'
gem 'devise-i18n', '>= 0.10.3'
gem 'devise-authy', '>= 1.5.0'
# FIXME: What's wrong here?
gem 'i18n', '= 0.6.9'
gem 'mysql2', '>= 0.3.15'
gem 'sqlite3', '>= 1.3.9'
gem 'elasticsearch'
gem 'searchkick', '>= 0.6.0'
gem 'ruby-saml', '>= 0.8.2'
gem 'ruby-saml-idp'
gem 'newrelic_rpm', '>= 3.7.3.204'
gem 'coveralls', require: false
gem 'kaminari', '>= 0.15.1'

gem 'canvas-api', '>= 1.0'

gem 'json'
gem 'strongbox', '~> 0.7.0'
gem 'paperclip', '~> 4.1.1'
gem 'tinymce-rails'

gem 'haml'
gem 'haml-rails', '~> 0.4'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'rails-assets-angular', '>= 1.3.5'
end
gem 'chardinjs-rails', '>= 0.1.3'
gem 'rails-assets-jquery-ui'
gem 'rails-assets-bootstrap-sass'
gem 'rails-assets-normalize-css'

group :development do
  gem 'quiet_assets'
  gem 'thin'
  gem 'hpricot'
  gem 'ruby_parser'

  gem 'rb-fsevent', '~> 0.9.4', require: false
  gem 'rb-inotify', '~> 0.9.3', require: false
  gem 'rb-fchange', require: false
end

gem 'minitest', '~> 4.7'
gem 'minitest-rails', '>= 0.9.2'

group :development, :test do
  gem 'railroady'
  gem 'minitest-colorize'
  gem 'minitest-focus'

  gem 'minitest-reporters'
  gem 'rspec-rails', '~>2.14'
  gem 'rspec-expectations', '2.14'
  gem 'rspec-mocks'
  gem 'rspec', '~> 2.14'
  gem 'simplecov'
  gem 'factory_girl_rails'
  gem 'jasmine'
  gem 'jasmine-jquery-rails'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'capybara', '>= 2.2.0'
  gem 'launchy'
  gem 'poltergeist'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
  gem 'cucumber-rails', require: false
  gem 'cucumber'
  gem 'database_cleaner'
  #  gem 'perftools.rb'
  #  gem 'rack-perftools_profiler', require: 'rack/perftools_profiler'
end

gem 'nokogiri', '= 1.6.3.1'
gem 'redis', '~> 3.0.4'
gem 'redis-rails'
gem 'redis-store'
gem 'redis-rack-cache'
if RUBY_VERSION =~ /1.9/
  gem 'sidekiq', '~>3.1.4'
else
  gem 'sidekiq'
end
gem 'sitemap'
gem 'friendly_id'
gem 'sshkit', group: :development
gem 'capistrano', group: :development
gem 'bundler'
gem 'capistrano-bundler', group: :development
# gem 'capistrano-rvm', group: :development
gem 'capistrano-rails', group: :development
gem 'rvm1-capistrano3', group: :development, require: false

gem 'unicorn', '>= 4.8.2'

gem 'sinatra', require: false
gem 'slim'

gem 'podio', git: 'https://github.com/webhat/podio-rb.git'
gem 'podiocrm', git: 'https://github.com/webhat/podiocrm.git'
# gem 'podiocrm', path: '../podiocrm'
gem 'paperclip_montage', '~> 0.1.2'
# gem 'paperclip_montage', path: '../paperclip_montage'
gem 'paperclip_redis', '~> 0.1.1'
# gem 'paperclip_redis', path: '../paperclip_redis'
