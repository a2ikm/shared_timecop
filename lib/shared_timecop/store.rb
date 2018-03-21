module SharedTimecop
  module Store
    require_relative "store/memory"

    if defined?(Rails)
      require_relative "store/rails_cache"
    end
  end
end
