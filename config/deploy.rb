set :application, 'Oplerno'
set :rails_env, 'production'

set :scm, :git
set :repo_url, 'git@github.com:webhat/oplerno.git'
set :branch, 'develop'

set :deploy_to, '/home/redhat/www'

set :linked_files, %w{config/database.yml config/newrelic.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system config/strongbox}

set :format, :pretty
set :log_level, :debug
set :pty, true
set :keep_releases, 10

set :default_env, {
    'DEVISE_SECRET' => ENV['DEVISE_SECRET'],
    'DEVISE_PEPPER' => ENV['DEVISE_PEPPER'],
    'DB' => 'mysql',
    'RAILS_ENV' => fetch(:rails_env),
    'PAYPAL_USER' => ENV['PAYPAL_USER'],
    'PAYPAL_PASS' => ENV['PAYPAL_PASS'],
    'PAYPAL_SIG' => ENV['PAYPAL_SIG'],
    'OPLERNO_KEYBASE' => ENV['OPLERNO_KEYBASE'],
    'OPLERNO_TOKEN' => ENV['OPLERNO_TOKEN'],
    'CANVAS_USERNAME' => ENV['CANVAS_USERNAME'],
    'CANVAS_PASSWORD' => ENV['CANVAS_PASSWORD'],
    'CANVAS_TOKEN' => ENV['CANVAS_TOKEN'],
    'MY_DEV_PASSWORD' => ENV['MY_DEV_PASSWORD'],
    'MYSQL_PASSWORD' => ENV['MYSQL_PASSWORD'],
    'NEWRELIC_KEY' => ENV['NEWRELIC_KEY'],
    'AUTHY_API_KEY' => ENV['AUTHY_API_KEY'],
    'PAPERCLIP_REDIS' => ENV['PAPERCLIP_REDIS'],
    'MAIL_PASSWORD' => ENV['MAIL_PASSWORD']
}

namespace :deploy do
  before :starting, 'github:ssh'
  before :starting, 'db:sync'

  desc 'Seed Admin User'
  task :seed do
    on roles(:db), in: :sequence, wait: 5 do
      within release_path do
        execute :rake, 'db:seed ; true'
      end
    end
  end

  desc 'Sync with Canvas'
  task :sync do
    on roles(:db), in: :sequence, wait: 5 do
      within release_path do
        execute :rake, 'cron'
      end
    end
  end

  after :updated, 'deploy:migrate'

	# Stub :restart
  task :restart do

	end

  after :publishing, 'app:restart'
  after :finishing, 'deploy:cleanup'
end

