set :application, 'Oplerno'
set :rails_env, 'test'

set :scm, :git
set :repo_url, 'git@github.com:webhat/oplerno.git'
set :branch, 'develop'

set :deploy_to, '/home/redhat/www'

set :format, :pretty
set :log_level, :debug
set :pty, true
set :keep_releases, 4

namespace :deploy do
  before :starting, 'github:ssh'

  desc 'Set Keys for Strongbox'
  task :set_keys do
    on roles(:app), in: :sequence, wait: 5 do
      execute :pwd
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :rm, options = '-rf', release_path.join('tmp')
      execute :mkdir, release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        # nothing
      end
    end
  end

  after :updated, 'deploy:migrate'

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

