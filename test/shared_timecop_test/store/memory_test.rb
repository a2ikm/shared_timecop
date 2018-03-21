require "test_helper"

class SharedTimecopStoreMemoryTest < Minitest::Test
  def store
    @store ||= SharedTimecop::Store::Memory.new
  end

  def create_stack_item
    Timecop::TimeStackItem.new(:freeze, 2017)
  end

  def test_read
    assert_nil store.read
  end

  def test_read_after_write
    stack_item = create_stack_item
    store.write(stack_item)
    assert_equal stack_item, store.read
  end

  def test_read_after_clear
    stack_item = create_stack_item
    store.write(stack_item)
    store.clear
    assert_nil store.read
  end
end
