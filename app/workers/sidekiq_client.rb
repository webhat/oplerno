Sidekiq.configure_client do |config|
  config.redis = {:namespace => 'instructure', :url => @config['config']['redis_url']}
end
