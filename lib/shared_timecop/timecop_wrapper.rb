module SharedTimecop
  module TimecopWrapper
    class <<self
      def mock!(time_stack_item)
        ivar = timecop.instance_variable_defined?(:@_stack) ? :@_stack : :@stack
        timecop.instance_variable_get(ivar).replace([time_stack_item])
      end

      def unmock!
        timecop.send(:unmock!)
      end

      private

      def timecop
        Timecop.instance
      end
    end
  end
end
