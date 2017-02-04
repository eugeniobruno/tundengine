module Tundengine
  module Cards
    class Card

      include AlgebraicDataType
      include Move

      attr_reader :rank, :suit

      def initialize(rank, suit)
        @rank = rank
        @suit = suit
        super()
      end

      def to_s
        "#{@rank.to_s} de #{@suit.to_s}"
      end

      def is_of_any_rank?(ranks)
        ranks.include? @rank
      end

      def is_of_any_suit?(suits)
        suits.include? @suit
      end

      def round_points
        @rank.round_points
      end

      # assumes other_card is winning the current trick
      def beats?(other_card, trump_suit)
        suit_powers = { other_card.suit => 1, trump_suit => 2 }
        suit_powers[Suits::Null.instance] = 0

        own_suit_power, other_suit_power = [@suit, other_card.suit]
          .map { |s| suit_powers.fetch(s, 0) }

        if own_suit_power == other_suit_power
          beats_same_suit?(other_card)
        else
          own_suit_power > other_suit_power
        end
      end

      def beats_same_suit?(other_card)
        @rank > other_card.rank
      end

      def exists?
        true
      end

      protected

      def state
        [@rank, @suit]
      end

    end
  end
end