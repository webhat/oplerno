Sidekiq.configure_client do |config|
  config.redis = {:namespace => 'instructure', :url => ENV['PAPERCLIP_REDIS']}
end
# Sidekiq server is multi-threaded so our Redis connection pool size defaults to concurrency (-c)
Sidekiq.configure_server do |config|
  config.redis = {:namespace => 'instructure', :url => ENV['PAPERCLIP_REDIS']}
end
