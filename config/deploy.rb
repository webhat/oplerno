set :application, 'Oplerno'
set :rails_env, 'test'

set :scm, :git
set :repo_url, 'git@github.com:webhat/oplerno.git'
set :branch, 'develop'

set :deploy_to, '/home/redhat/www'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system config/strongbox}

set :format, :pretty
set :log_level, :debug
set :pty, true
set :keep_releases, 4

namespace :deploy do
  before :starting, 'github:ssh'

  desc 'Restart application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute 'unicorn_rails -c www/current/config/unicorn.rb -E production -D'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, shared_path.join('tmp/pids/unicorn.pid')
      begin
        Process.kill("USR2", File.read(release_path.join('tmp/pids/unicorn.pid')).to_i)
      rescue
      end
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

