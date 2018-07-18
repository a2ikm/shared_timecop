module SharedTimecop
  module Store
    class <<self
      def registry
        @registry ||= {}
      end

      def register(name, klass)
        registry[name.to_sym] = klass
      end

      def lookup!(name)
        klass = registry[name.to_sym]

        if klass.nil?
          raise RuntimeError, "`#{name}` isn't registered as a store."
        end

        klass
      end
    end

    require_relative "store/memory"
    require_relative "store/server"

    if defined?(Rails)
      require_relative "store/rails_cache"
    end
  end
end
