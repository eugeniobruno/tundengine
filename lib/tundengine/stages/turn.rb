module Tundengine
  module Stages
    class Turn < Base

      attr_reader :card

      def initialize(trick)
        @card = Cards::Null.instance
        super
      end

      alias_method :trick,  :parent
      alias_method :player, :child_in_play

      def player_in_round
        player.in_round
      end

      def play!(card = Cards::Null.instance)
        player.play!(card)
      end

      def on_completed!(card, beats)
        @card = card
        trick.on_complete_child!(beats)
      end

      def as_hash
        { player: player.name, card: card.to_s }
      end

      protected

      def new_child
        Player::InTurn.new(self, trick.next_player)
      end

      def completed?
        card.exists?
      end

    end
  end
end