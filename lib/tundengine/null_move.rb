module Tundengine
  module NullMove

    def yield_self_or_lock!(node)
      node.lock!
    end

    def self_or_yield
      yield
    end

  end
end