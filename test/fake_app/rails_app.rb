class SharedTimecopTestApp < Rails::Application
  config.root = __dir__
  config.eager_load = false
  config.cache_store = :memory_store
end

Rails.application.initialize!
