module Tundengine
  module Strategies
    class Random < Automatic

      def play(player_in_turn)
        player_in_turn.hand.playable_cards(player_in_turn.turn.trick).first.first
      end

      def declare(player_in_round)
        Declarations::Void.instance
      end

    end
  end
end