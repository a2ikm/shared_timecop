require "timecop"
require "shared_timecop/timecop_wrapper"
require "shared_timecop/version"

module SharedTimecop
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

    private

    def save_stack_item(stack_item)
      @stack_item = stack_item
    end

    def load_stack_item
      @stack_item
    end

    def clear_stack_item
      @stack_item = nil
    end
  end
end
