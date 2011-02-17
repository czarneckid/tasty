require 'helper'
require 'mocha'
require 'fakeweb'

class TestTasty < Test::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end
  
  def teardown
    FakeWeb.allow_net_connect = true
  end

  def test_version_is_current
    assert_equal '1.0.1', Tasty::VERSION
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
  
  def test_can_retrieve_all_posts
    FakeWeb.register_uri(:get, 
                         'https://username:password@api.del.icio.us/v1/posts/all?', 
                         :body => File.join(File.dirname(__FILE__), 'fakeweb', 'delicious_posts_all_response.xml'), 
                         :content_type => "application/xml")
                         
    tasty = Tasty.new('username', 'password')
    tasty_response = tasty.get('posts/all')
    
    assert_equal 2, tasty_response['posts']['post'].size
  end
  
  def test_can_add_post
    FakeWeb.register_uri(:post, 
                         'https://username:password@api.del.icio.us/v1/posts/add?', 
                         :body => File.join(File.dirname(__FILE__), 'fakeweb', 'delicious_posts_add_response.xml'), 
                         :content_type => "application/xml")
    
    tasty = Tasty.new('username', 'password')
    tasty_response = tasty.post('posts/add', :url => 'http://www.google.com', :description => 'The best search engine')
    
    assert_equal 'done', tasty_response['result']['code']
  end
  
  def test_can_set_timeout
    tasty = Tasty.new('username', 'password')
    tasty.expects(:default_timeout).at_least_once
    
    tasty.set_timeout(5)
  end  
end
