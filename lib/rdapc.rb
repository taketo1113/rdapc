require "rdapc/version"
require "rdapc/client"

module Rdapc
  class << self
    def lookup(query:)
      hoge = Rdapc::Client.new(query: query)

      hoge.get
    end
  end
end
