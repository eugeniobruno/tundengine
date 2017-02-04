module Tundengine
  class Dealer

    include Singleton

    def deal!(players, trump_suit, options = {})
      default_options = {
        premade_hands: Hash.new([])
      }
      options = default_options.merge(options)

      premade_hands = options.fetch :premade_hands

      validate_premade_hands(premade_hands)

      premade_players_names = premade_hands.keys.map(&:name)
      premade_players, other_players = players.partition do |p|
        premade_players_names.include? p.name
      end

      premade_players.each do |p|
        premade_hands[p].each { |c| p.take_card! c }
      end

      premade_cards = premade_hands.values.flatten(1)

      all_cards = Deck.for(players.length, trump_suit).shuffle
      do_deal!(other_players, all_cards - premade_cards)
    end

    protected

    def do_deal!(players, cards)
      number_of_players = players.length
      cards.each_with_index do |c, i|
        players[i % number_of_players].take_card! c
      end
    end

    def validate_premade_hands(hands)
      if hands.values.map(&:length).uniq.length > 1
        raise "all premade hands must have the same amount of cards"
      end

      premade_cards = hands.values.flatten(1)
      unless premade_cards.length == premade_cards.uniq.length
        raise "premade hands cannot share cards"
      end
    end

  end
end