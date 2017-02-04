module Tundengine
  module Player
    class InTurn

      extend Forwardable
      def_delegators :@in_round, :name, :strategy, :hand

      attr_reader :turn, :in_round

      def initialize(turn, player_in_round)
        @turn     = turn
        @in_round = player_in_round
      end

      def play!(card = Cards::Null.instance)
        strategy.play!(self, card)
      end

      def after_playing!(card)
        playable_cards, beats = hand.playable_cards(turn.trick)
        if playable_cards.include? card
          hand.delete card
          turn.on_completed!(card, beats)
        else
          raise "cannot play card #{card} in trick with cards #{turn.trick.cards.map(&:to_s)} when your hand is #{@hand.map(&:to_s)}"
        end
      end

    end
  end
end