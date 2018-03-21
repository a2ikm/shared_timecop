require "test_helper"

class SharedTimecopTest < Minitest::Test
  def teardown
    SharedTimecop.store = :memory
  end

  def test_freeze
    now = Time.now
    SharedTimecop.freeze(now)

    sleep 1

    refute_equal now, Time.now
  ensure
    SharedTimecop::TimecopWrapper.unmock!
  end

  def test_freeze_and_go
    now = Time.now
    SharedTimecop.freeze(now)

    sleep 1

    SharedTimecop.go
    assert_equal now, Time.now
  ensure
    SharedTimecop::TimecopWrapper.unmock!
  end

  def test_freeze_and_go_and_return
    now = Time.now
    SharedTimecop.freeze(now)

    sleep 1

    SharedTimecop.go
    SharedTimecop.return
    refute_equal now, Time.now
  ensure
    SharedTimecop::TimecopWrapper.unmock!
  end

  def test_freeze_and_go_with_block
    now = Time.now
    SharedTimecop.freeze(now)

    sleep 1

    SharedTimecop.go do
      assert_equal now, Time.now
    end

    refute_equal now, Time.now
  ensure
    SharedTimecop::TimecopWrapper.unmock!
  end

  def test_reset_and_go
    now = Time.now
    SharedTimecop.freeze(now)
    SharedTimecop.reset

    sleep 1

    SharedTimecop.go
    refute_equal now, Time.now
  ensure
    SharedTimecop::TimecopWrapper.unmock!
  end

  def test_set_store
    SharedTimecop.store.is_a?(SharedTimecop::Store::Memory)

    SharedTimecop.store = :rails_cache
    SharedTimecop.store.is_a?(SharedTimecop::Store::RailsCache)
  end
end
