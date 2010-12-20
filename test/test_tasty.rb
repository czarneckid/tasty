require 'helper'
require 'mocha'

class TestTasty < Test::Unit::TestCase
  def test_version_is_current
    assert_equal '1.0.0', Tasty::VERSION
  end
  
  def test_can_initialize_new_tasty_class
    tasty = Tasty.new('username', 'password')
    
    assert_equal Tasty::DELICIOUS_API_URL, tasty.delicious_api_url
    assert_equal 'username', tasty.username
    assert_equal 'password', tasty.password
  end
  
  def test_can_set_http_headers
    tasty = Tasty.new('username', 'password')
    tasty.expects(:headers).at_least_once
    
    tasty.set_http_headers({'Accept' => 'application/xml'})
  end
  
end
