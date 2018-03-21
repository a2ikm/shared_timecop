class Timecop
  class TimeStackItem
    IVARS = %i(
      @travel_offset
      @scaling_factor
      @mock_type
      @time
      @time_was
      @travel_offset).freeze
    def ==(other)
      super || other.is_a?(self.class) &&
        IVARS.all? { |ivar| other.instance_variable_get(ivar) == self.instance_variable_get(ivar) }
    end
    alias eq? ==
  end
end
