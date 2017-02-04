module Tundengine
  module AlgebraicDataType

    def initialize
      freeze
    end

    def to_s
      (state.one? ? state.first : state).to_s
    end

    def ==(o)
      o.class == self.class && o.state == state
    end

    alias_method :eql?, :==

    def hash
      state.hash
    end

    protected

    def state
      [self.class.name.split('::').last].concat identifier
    end

    def identifier
      []
    end

  end
end