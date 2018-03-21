require "test_helper"

class SharedTimecopStoreTest < Minitest::Test
  def store
    SharedTimecop::Store
  end

  def test_lookup_after_register
    klass = Class.new
    store.register(:something, klass)
    result = store.lookup!(:something)
    assert_equal klass, result
  end

  def test_lookup_without_register
    assert_raises { store.lookup!(:not_registered) }
  end
end
