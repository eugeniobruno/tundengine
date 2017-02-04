module Tundengine
  module Declarations
    class Base

      include StringifiableByClass
      include Move

      attr_reader :round_points

      def initialize
        @round_points = self.class::ROUND_POINTS
      end

      def has_tute_effect?(tute_value)
        false
      end

      def finishes_round?(tute_value)
        false
      end

    end
  end
end