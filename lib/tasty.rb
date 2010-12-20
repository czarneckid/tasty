require 'httparty'

class Tasty
  include HTTParty
  
  VERSION = '1.0.0'.freeze
  DEFAULT_HEADERS = {
    'User-Agent' => "tasty gem #{VERSION}"
  }
  
  headers(DEFAULT_HEADERS)
  
  DELICIOUS_API_URL = 'https://api.del.icio.us/v1'
  
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
  
end