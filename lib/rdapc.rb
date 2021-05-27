require "rdapc/version"
require "rdapc/client"

module Rdapc
  class << self
    def lookup(type:, query:)
      client = Rdapc::Client.new(type: type, query: query)

      unless client.valid?
        # TODO: return Error Object
        return
      end

      client.get
    end
  end
end
