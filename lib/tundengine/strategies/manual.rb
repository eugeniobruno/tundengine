module Tundengine
  module Strategies
    class Manual < Base

      def play!(player_in_turn, card)
        card.yield_self_or_lock!(player_in_turn.turn) do |c|
          do_play!(player_in_turn, c)
        end
      end

      def declare!(player_in_round, declaration)
        declaration.yield_self_or_lock!(player_in_round.round) do |d|
          do_declare!(player_in_round, d)
        end
      end

      def on_winning_trick!(player_in_round)
        # do nothing
      end

      protected

      def do_play!(player_in_turn, card)
        player_in_turn.after_playing!(card)
      end

      def do_declare!(player_in_round, declaration)
        player_in_round.after_declaring!(declaration)
      end

    end
  end
end