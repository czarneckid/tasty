require 'httparty'
require 'tasty/version'

class Tasty
  include HTTParty
  
  DEFAULT_HEADERS = {
    'User-Agent' => "tasty gem #{VERSION}"
  }
  
  headers(DEFAULT_HEADERS)
  
  DELICIOUS_API_URL = 'https://api.del.icio.us/v1/'
  
  attr_accessor :delicious_api_url
  attr_accessor :username
  attr_accessor :password

  # Initialize with your API token  
  def initialize(username, password, delicious_api_url = DELICIOUS_API_URL)
    @username = username
    @password = password
    @delicious_api_url = delicious_api_url
  end
  
  def debug(location = $stderr)
    self.class.debug_output(location)
  end
      
  def set_http_headers(http_headers = {})
    http_headers.merge!(DEFAULT_HEADERS)
    headers(http_headers)
  end

  def set_timeout(timeout)
    default_timeout(timeout)
  end

  # Call del.icio.us using a particular API method, api_method. The options hash is where you can add any parameters appropriate for the API call.
  def get(api_method, options = {})
    query = {}
    query.merge!(authorization_hash)
    query.merge!({:query => options})
          
    self.class.get(@delicious_api_url + api_method, query)
  end
  
  # Post to del.icio.us using a particular API method, api_method. The parameters hash is where you add all the required parameters appropriate for the API call.
  def post(api_method, options = {}) 
    query = {}
    query.merge!(authorization_hash)
    query.merge!({:body => options})
              
    self.class.post(@delicious_api_url + api_method, query)    
  end
  
  private
  
  def authorization_hash
    {:basic_auth => {:username => @username, :password => @password}}
  end
end