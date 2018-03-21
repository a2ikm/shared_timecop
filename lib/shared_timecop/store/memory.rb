module SharedTimecop::Store
  class Memory
    def initialize
      @stack_item = nil
    end

    def read
      @stack_item
    end

    def write(stack_item)
      @stack_item = stack_item
    end

    def clear
      @stack_item = nil
    end
  end
end
