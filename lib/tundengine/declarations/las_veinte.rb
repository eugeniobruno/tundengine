module Tundengine
  module Declarations
    class LasVeinte < Base

      include AlgebraicDataType

      ROUND_POINTS = 20

      def self.en(suit)
        s = suit.is_a?(Suits::Base) ? suit : suit.instance
        new(s)
      end

      def initialize(suit)
        @suit = suit
        super()
      end

      def is_declarable?(hand, trump_suit)
        @suit != trump_suit and hand.has_knight_and_king_of?(@suit)
      end

      def identifier
        [@suit]
      end

    end
  end
end