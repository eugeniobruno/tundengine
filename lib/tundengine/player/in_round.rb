module Tundengine
  module Player
    class InRound

      extend Forwardable
      def_delegators :@in_match, :name, :strategy

      attr_reader   :in_match, :hand, :declarations
      attr_writer   :bonus_points
      attr_accessor :round

      def initialize(player_in_match)
        @in_match     = player_in_match
        @round        = :no_round_set
        @hand         = Hand.new([])
        @baza         = []
        @declarations = []
        @round_points = 0
        @bonus_points = 0
      end

      def take_card!(card)
        hand << card
      end

      def declare!(declaration = Declarations::Null.instance)
        strategy.declare!(self, declaration)
      end

      def after_declaring!(declaration)
        if declaration.is_declarable?(hand, round.trump_suit)
          declarations << declaration
          round.after_declaring!(declaration)
        else
          raise "cannot declare #{declaration} after trick #{round.current_trick.summary} with hand #{hand}"
        end
      end

      def on_winning_trick!(trick)
        take! trick
        declare!
      end

      def take!(trick)
        @baza = @baza.concat trick.cards
        @round_points += trick.points
      end

      def has_empty_hand?
        hand.empty?
      end

      def has_empty_baza?
        @baza.empty?
      end

      def total_round_points
        @round_points + @bonus_points
      end

      def summary
        {
          name: name,
          hand: hand.map(&:to_s),
          baza: @baza.map(&:to_s)
        }
      end

    end
  end
end