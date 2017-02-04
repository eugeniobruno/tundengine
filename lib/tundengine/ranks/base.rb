module Tundengine
  module Ranks
    class Base

      include Singleton
      include StringifiableByClass
      include Comparable

      attr_reader :round_points, :power

      def self.de(suit)
        instance.de(suit)
      end

      def de(suit)
        s = suit.is_a?(Suits::Base) ? suit : suit.instance
        Cards::Card.new(self, s)
      end

      def <=>(other_rank)
        @power <=> other_rank.power
      end

      def initialize
        @round_points = self.class::ROUND_POINTS
        @power        = self.class::POWER
      end

    end
  end
end