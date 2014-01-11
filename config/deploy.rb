set :application, 'Oplerno'

set :scm, :git
set :repo_url, 'git@github.com:webhat/oplerno.git'
set :branch, 'develop'

set :deploy_to, '/home/redhat/www'

set :format, :pretty
set :log_level, :debug
set :keep_releases, 4

namespace :deploy do
  before :starting, 'github:ssh'

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
        execute :rake, 'cache:clear'
      end
    end
  end

  after :finishing, 'deploy:cleanup'
end
