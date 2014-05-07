source 'https://rubygems.org'
source 'https://rails-assets.org'

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'libnotify', :require => RUBY_PLATFORM.include?('linux') && 'rb-inotify'
gem 'growl', :require => RUBY_PLATFORM.include?('darwin') && 'growl'

gem 'rails', '3.2.15'
gem 'jquery-rails', '< 3.0.0' #, '>= 3.1.0'

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

gem 'activeadmin', '>= 0.6.3'
gem 'paper_trail'
gem 'activemerchant', '>= 1.42.7'
gem 'devise', '>= 3.2.4'
gem 'devise-i18n', '>= 0.10.3'
gem 'devise-authy', '>= 1.5.0'
gem 'mysql2', '>= 0.3.15'
gem 'sqlite3', '>= 1.3.9'
gem 'elasticsearch'
gem 'searchkick', '>= 0.6.0'
gem 'ruby-saml', '~> 0.7.2'
gem 'ruby-saml-idp'
gem 'newrelic_rpm', '>= 3.7.3.204'
gem 'coveralls', require: false
gem 'kaminari', '>= 0.15.1'

gem 'canvas-api', '>= 1.0'

gem 'json'
gem 'strongbox', '~> 0.7.0'
gem 'paperclip', '>= 4.1.1'
gem 'tinymce-rails'

gem 'haml'
gem 'haml-rails', '~> 0.4'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'chardinjs-rails', '>= 0.1.3'
gem 'rails-assets-jquery-ui'
gem 'rails-assets-bootstrap-sass'
gem 'rails-assets-angular'
gem 'rails-assets-normalize-css'

group :development do
  gem 'quiet_assets'
  gem 'thin'
	gem 'hpricot'
	gem 'ruby_parser'

  gem 'rb-fsevent', '~> 0.9.4', :require => false
  gem 'rb-inotify', '~> 0.9.3', :require => false
  gem 'rb-fchange', :require => false
end

gem 'minitest', '~> 4.7'
gem 'minitest-rails', '>= 0.9.2'

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
  gem 'jasmine-jquery-rails'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'capybara'
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

gem 'redis'
gem 'sshkit', group: :development
gem 'capistrano', group: :development
gem 'bundler'
gem 'capistrano-bundler', group: :development
#gem 'capistrano-rvm', group: :development
gem 'capistrano-rails', group: :development
gem 'rvm1-capistrano3', group: :development, :require => false

gem 'unicorn', '>= 4.8.2' #, group: :production


group :test, :production do
	gem 'paperclip_redis', '> 0.0.8'
	#gem 'paperclip_redis', path: 'lib/paperclip_redis'
end

