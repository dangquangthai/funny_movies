redis_url = ENV['REDIS_URL'].presence || "redis://127.0.0.1:6379/1"

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, network_timeout: 5 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, network_timeout: 5 }
end
