require 'rspec'
require 'fakeweb'
require 'tasty'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) do
    FakeWeb.allow_net_connect = false
  end

  config.after(:each) do
    FakeWeb.allow_net_connect = true
    FakeWeb.clean_registry
  end
end