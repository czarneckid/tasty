require 'httparty'

class Tasty
  include HTTParty
  
  VERSION = '1.0.0'.freeze
  DEFAULT_HEADERS = {
    'User-Agent' => "tasty gem #{VERSION}"
  }
  
  headers(DEFAULT_HEADERS)
end