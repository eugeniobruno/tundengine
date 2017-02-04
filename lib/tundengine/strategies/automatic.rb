module Tundengine
  module Strategies
    class Automatic < Base

      def play!(player_in_turn, card)
        selected_card = card.self_or_yield do
          play(player_in_turn)
        end

        player_in_turn.after_playing!(selected_card)
      end

      def declare!(player_in_round, declaration)
        selected_declaration = declaration.self_or_yield do
          declare(player_in_round)
        end

        player_in_round.after_declaring!(selected_declaration)
      end

      def on_winning_trick!(player_in_round)
        player_in_round.declare!
      end

    end
  end
end