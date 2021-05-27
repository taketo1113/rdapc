require 'net/http'
require "json"

module Rdapc
  class Client
    def initialize(query: '')
      @url = "https://rdap.arin.net/registry/ip/#{query}"
    end

    def get
      response = Net::HTTP.get_response(URI.parse(@url))

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)

      when Net::HTTPRedirection
        #get(response['location'], limit - 1)
        get(response['location'])

      else
        response.body

      end
    end
  end
end
