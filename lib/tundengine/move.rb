module Tundengine
  module Move

    def yield_self_or_lock!(node)
      yield self
    end

    def self_or_yield
      self
    end

  end
end