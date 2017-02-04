module Tundengine
  class Deck

    RANK_CLASSES = %w(Uno Dos Tres Cuatro Cinco Seis Siete Diez Once Doce)
      .map { |r| Object.const_get("Tundengine::Ranks::#{r}") }

    SUIT_CLASSES = %w(Oro Copa Espada Basto)
      .map { |s| Object.const_get("Tundengine::Suits::#{s}") }

    RANKS = RANK_CLASSES.map(&:instance).freeze

    SUITS = SUIT_CLASSES.map(&:instance).freeze

    CARDS = SUITS.product(RANKS).map { |s, r| r.de s }.freeze

    DECLARATIONS = SUITS.map { |s| Declarations::LasVeinte.en(s) }
                        .concat(  [Declarations::LasCuarenta, Declarations::Tute,
                                   Declarations::Void]
                                  .map(&:instance)).freeze

    class << self

      def for(number_of_players, trump_suit)
        case number_of_players
        when 3
          CARDS - [Ranks::Dos.de(trump_suit)]
        when 4..5
          CARDS
        else
          raise "invalid number of players: #{number_of_players}"
        end
      end

      def cards_of(ranks = RANKS, suits = SUITS)
        CARDS.select { |c| c.is_of_any_rank? ranks and c.is_of_any_suit? suits }
      end

    end

  end
end