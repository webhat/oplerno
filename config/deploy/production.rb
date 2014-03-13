set :stage, :production

role :app, %w{deploy@app01 deploy@app02}
role :web, %w{deploy@web01 deploy@web02}
role :db, %w{deploy@db01}

set :ssh_options, {
    keys: %w(~/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey),
}
