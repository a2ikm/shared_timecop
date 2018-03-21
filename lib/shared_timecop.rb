require "timecop"

module SharedTimecop
  require_relative "shared_timecop/store"
  require_relative "shared_timecop/timecop_wrapper"
  require_relative "shared_timecop/version"

  if defined?(::Rack)
    require_relative "shared_timecop/rack_middleware"
  end

  if defined?(::Sidekiq)
    require_relative "shared_timecop/sidekiq_server_middleware"
  end

  class <<self
    def travel(*args)
      stack_item = Timecop::TimeStackItem.new(:travel, *args)
      save_stack_item(stack_item)
      true
    end

    def freeze(*args)
      stack_item = Timecop::TimeStackItem.new(:freeze, *args)
      save_stack_item(stack_item)
      true
    end

    def go
      stack_item = load_stack_item
      if stack_item
        TimecopWrapper.mock!(stack_item)

        if block_given?
          begin
            yield stack_item.time
          ensure
            TimecopWrapper.unmock!
          end
        else
          true
        end
      else
        if block_given?
          yield
        else
          false
        end
      end
    end

    def return
      TimecopWrapper.unmock!
      true
    end

    def reset
      TimecopWrapper.unmock!
      clear_stack_item
      true
    end

    def store
      @store ||= Store.lookup!(:memory).new
    end

    def store=(name, *options)
      @store = Store.lookup!(name).new(*options)
    end

    private

    def save_stack_item(stack_item)
      store.write(stack_item)
    end

    def load_stack_item
      store.read
    end

    def clear_stack_item
      store.clear
    end
  end
end
