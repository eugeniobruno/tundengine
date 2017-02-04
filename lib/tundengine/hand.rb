module Tundengine
  class Hand < SimpleDelegator

    # returns the playable cards and whether any of them would beat the current trick
    def playable_cards(trick)

      suit_followers = trick.first_suit.percolate(self)
      trick_beaters  = trick           .percolate(self)

      suit_followers_trick_beaters = suit_followers & trick_beaters

      [
        [suit_followers_trick_beaters, true ],
        [suit_followers,               false],
        [trick_beaters,                true ],
        [self,                         false]
      ]
      .find { |cards_subset, _| not cards_subset.empty? }

    end

    def has_knight_and_king_of?(suit)
      has_all_of?([Ranks::Once, Ranks::Doce].map(&:instance), suit)
    end

    def has_all_of?(ranks = Deck::RANKS, suits = Deck::SUITS)
      Deck.cards_of(Array(ranks), Array(suits)).all? { |c| self.include? c }
    end

    def to_s
      "[#{map(&:to_s).join(', ')}]"
    end

  end
end