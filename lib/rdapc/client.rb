require 'net/http'
require "json"

module Rdapc
  class Client
    def initialize(type: nil, query: '')
      @type = type
      @query = query

      @url = "https://rdap.arin.net/registry/ip/#{query}"
    end

    TYPES = [
      :ip,
      :autnum,
      :domain,
      :nameserver,
      :entity,
    ]

    def valid?
      unless valid_type?(@type)
        return false
      end

      unless valid_query?(@query)
        return false
      end

      return true
    end

    def valid_query?(query)
      if query.nil? || query.empty?
        raise(ArgumentError, "`query` can't be nil")
      end

      return true
    end

    def valid_type?(type)
      if type.nil?
        raise(ArgumentError, "`type` can't be nil")
      end

      unless TYPES.include?(type)
        raise(ArgumentError, "`#{type}` is not a valid definition type")
      end

      return true
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
