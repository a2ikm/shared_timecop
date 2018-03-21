require "test_helper"

class SharedTimecopStoreRailsCacheTest < Minitest::Test
  def teardown
    Rails.cache.clear
  end

  def store
    @store ||= SharedTimecop::Store::RailsCache.new
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
