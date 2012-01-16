require 'httparty'
require 'tasty/version'

class Tasty
  include HTTParty
  
  DEFAULT_HEADERS = {
    'User-Agent' => "tasty gem #{VERSION}"
  }
  
  DELICIOUS_API_URL = 'https://api.del.icio.us/v1/'

  headers(DEFAULT_HEADERS)

  # URL for accessing del.icio.us  
  attr_accessor :delicious_api_url

  # del.icio.us username
  attr_accessor :username

  # del.icio.us password
  attr_accessor :password

  # Create a new instance for interacting with del.icio.us
  #
  # @param username [String] del.icio.us username
  # @param password [String] del.icio.us password
  # @delicious_api_url [String] Override the URL used to access the del.icio.us API
  def initialize(username, password, delicious_api_url = DELICIOUS_API_URL)
    @username = username
    @password = password
    @delicious_api_url = delicious_api_url
  end
  
  # Turn on HTTParty debugging
  # 
  # @param location [Object] Output "sink" for HTTP debugging
  def debug(location = $stderr)
    self.class.debug_output(location)
  end
      
  # Set new HTTP headers for requests
  # 
  # @param http_headers [Hash] HTTP headers
  def set_http_headers(http_headers = {})
    http_headers.merge!(DEFAULT_HEADERS)
    headers(http_headers)
  end

  # Set new HTTP timeout for requests
  #
  # @param timeout [int] Timeout in seconds
  def set_timeout(timeout)
    default_timeout(timeout)
  end

  # GET from del.icio.us using a particular API method, +api_method+. 
  #
  # @param api_method [String] del.icio.us API method.
  # @param options [Hash] The options hash is where you can add any parameters appropriate for the API call.
  def get(api_method, options = {})
    query = {}
    query.merge!(authorization_hash)
    query.merge!({:query => options})
          
    self.class.get(@delicious_api_url + api_method, query)
  end
  
  # POST to del.icio.us using a particular API method, +api_method+. 
  # 
  # @param api_method [String] del.icio.us API method.
  # @param options [Hash] The options hash is where you add all the required parameters appropriate for the API call.
  def post(api_method, options = {}) 
    query = {}
    query.merge!(authorization_hash)
    query.merge!({:body => options})
              
    self.class.post(@delicious_api_url + api_method, query)    
  end
  
  private
  
  # Setup the basic authorization hash for making requests to del.icio.us.
  #
  # @return Basic authorization hash for making requests to del.icio.us.
  def authorization_hash
    {:basic_auth => {:username => @username, :password => @password}}
  end
end