module Tundengine
  module Player
    class InMatch

      include AlgebraicDataType

      attr_reader :name, :strategy

      def initialize(name, strategy)
        @name         = name
        @strategy     = strategy
        @match_points = 0
      end

      def to_s
        @name
      end

      def identifier
        [@name]
      end

      def in_new_round
        InRound.new(self)
      end

    end
  end
end