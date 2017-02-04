require 'minitest/autorun'
require 'tundengine'

class TestCardStrength < Minitest::Test

  def setup
    @all_suits = Tundengine::Deck::SUITS
    @all_cards = Tundengine::Deck::CARDS
  end

  def test_that_null_always_loses

    null_card = Tundengine::Cards::Null.instance

    @all_suits.each do |trump_suit|
      @all_cards.each do |card|
        assert_equal(true,  card.beats?(null_card, trump_suit))
        assert_equal(false, null_card.beats?(card, trump_suit))
      end
    end

  end

  def test_that_trump_always_wins_against_no_trump

    @all_suits.each do |trump_suit|
      trump_cards, no_trump_cards = trump_suit.percolate(@all_cards, :partition)
      pairs = trump_cards.product(no_trump_cards)

      pairs.each do |trump_card, no_trump_card|
        assert_equal(true,  trump_card.beats?(no_trump_card, trump_suit))
        assert_equal(false, no_trump_card.beats?(trump_card, trump_suit))
      end
    end

  end

  def test_strength_with_no_trumps

    @all_suits.each do |trump_suit|
      _, no_trump_cards = trump_suit.percolate(@all_cards, :partition)
      pairs = no_trump_cards.product(no_trump_cards)
      same_suit, different_suits = pairs.partition { |c1, c2| c1.suit == c2.suit }

      same_suit.each do |c1, c2|
        assert_equal(c1.rank > c2.rank, c1.beats?(c2, trump_suit))
        assert_equal(c1.rank < c2.rank, c2.beats?(c1, trump_suit))
      end

      different_suits.each do |c1, c2|
        assert_equal(false, c1.beats?(c2, trump_suit))
        assert_equal(false, c2.beats?(c1, trump_suit))
      end
    end

  end

end