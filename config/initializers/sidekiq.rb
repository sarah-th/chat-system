Sidekiq.configure_server do |config|
    config.redis = { host:'localhost', port: 6379, db: 1 }
end

Sidekiq.configure_client do |config|
    config.redis = { host:'localhost', port: 6379, db: 1 }
end