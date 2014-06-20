# Sidekiq server is multi-threaded so our Redis connection pool size defaults to concurrency (-c)
Sidekiq.configure_server do |config|
  config.redis = {:namespace => 'instructure', :url => @config['config']['redis_url']}
end
