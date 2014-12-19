set :stage, :production

set :branch, 'develop'
set :deploy_to, '/home/deploy/www'

server 'app01', user: 'deploy', roles: [:web, :app]
server 'app02', user: 'deploy', roles: [:web, :app]
server 'db01', user: 'deploy', roles: [:db]

set :ssh_options, {
  keys: %w(~/.ssh/oplerno),
  forward_agent: true,
  auth_methods: %w(publickey),
}
