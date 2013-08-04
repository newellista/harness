require_relative '../test_helper'
require 'redis'

class RedisInstrumenterTest < MiniTest::Unit::TestCase
  def test_reports_the_memory_as_a_gauge
    instrumentor = Harness::RedisInstrumenter.new(Redis.new)
    instrumentor.log

    refute_empty gauges
    gauge = gauges.first
    assert_equal 'redis.memory', gauge.name
    assert_kind_of Fixnum, gauge.value
  end
end