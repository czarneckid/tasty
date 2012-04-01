require 'spec_helper'

describe Tasty do
  it 'should be the correct version' do
    Tasty::VERSION.should == '1.0.1'
  end

  it 'should have the correct initialization parameters' do
    tasty = Tasty.new('username', 'password')
    
    tasty.delicious_api_url.should == Tasty::DELICIOUS_API_URL
    tasty.username.should == 'username'
    tasty.password.should == 'password'
  end

  it 'should allow you to set HTTP headers' do
    tasty = Tasty.new('username', 'password')
    tasty.should_receive(:set_http_headers).with({'Accept' => 'application/xml'})
    
    tasty.set_http_headers({'Accept' => 'application/xml'})
  end

  it 'should allow you to set an HTTP timeout' do
    tasty = Tasty.new('username', 'password')
    tasty.should_receive(:default_timeout).with(5)
    
    tasty.set_timeout(5)
  end

  it 'should allow you to retrieve all posts' do
    FakeWeb.register_uri(:get, 
                         'https://username:password@api.del.icio.us/v1/posts/all?', 
                         :body => File.join(File.dirname(__FILE__), 'fakeweb', 'delicious_posts_all_response.xml'), 
                         :content_type => "application/xml")
                         
    tasty = Tasty.new('username', 'password')
    tasty_response = tasty.get('posts/all')
    
    tasty_response['posts']['post'].size.should == 2
  end

  it 'should allow you to add a post' do
    FakeWeb.register_uri(:post, 
                         'https://username:password@api.del.icio.us/v1/posts/add?', 
                         :body => File.join(File.dirname(__FILE__), 'fakeweb', 'delicious_posts_add_response.xml'), 
                         :content_type => "application/xml")
    
    tasty = Tasty.new('username', 'password')
    tasty_response = tasty.post('posts/add', :url => 'http://www.google.com', :description => 'The best search engine')
    
    tasty_response['result']['code'].should == 'done'
  end
end