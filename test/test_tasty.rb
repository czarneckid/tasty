require 'helper'

class TestTasty < Test::Unit::TestCase
  def test_version_is_current
    assert_equal '1.0.0', Tasty::VERSION
  end
end
