module Tundengine
  module Declarations
    class LasCuarenta < Base

      include Singleton

      ROUND_POINTS = 40

      def is_declarable?(hand, trump_suit)
        hand.has_knight_and_king_of?(trump_suit)
      end

    end
  end
end