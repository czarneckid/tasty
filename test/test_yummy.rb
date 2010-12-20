require 'helper'

class TestYummy < Test::Unit::TestCase
  def test_version_is_current
    assert_equal '1.0.0', Yummy::VERSION
  end
end
