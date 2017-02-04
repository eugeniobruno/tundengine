module Tundengine
  module Declarations
    class Tute < Base

      include Singleton

      ROUND_POINTS = :no_round_points

      def is_declarable?(hand, trump_suit)
        [Ranks::Once, Ranks::Doce].any? { |rank| hand.has_all_of? rank.instance }
      end

      def has_tute_effect?(tute_value)
        tute_value.has_effect?
      end

      def finishes_round?(tute_value)
        tute_value.finishes_round?
      end

    end
  end
end