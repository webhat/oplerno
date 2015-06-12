set :stage, :staging

# role :app, %w{oplerno}
# role :web, %w{oplerno}
# role :db, %w{oplerno}

server 'oplerno', user: 'redhat', roles: [:web, :db, :app]

set :branch, 'develop'

set :ssh_options, {
  keys: %w(~/.ssh/id_ecdsa),
  forward_agent: true,
  auth_methods: %w(publickey),
  #verbose: :debug
}

