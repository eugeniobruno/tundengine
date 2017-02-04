require 'minitest/autorun'
require 'tundengine'
require_relative './test_helper'

class TestPlayableCards < Minitest::Test

  include TestHelper

  def test_starting_first_trick

    setup!

    expected = [@@new_hand, true]
    actual   = @@new_hand.playable_cards(@@new_trick)

    assert_equal expected, actual
  end

  def test_starting_last_trick

    setup!

    @@all_cards.each do |card|
      hand = Tundengine::Hand.new([card])

      expected = [hand, true]
      actual   = hand.playable_cards(@@new_trick)

      assert_equal expected, actual
    end

  end

  def test_in_trick_with_one_card

    setup!(:all_manual)

    trick = @@new_trick

    hand = Tundengine::Hand.new([
      Tundengine::Ranks::Cinco.de(Tundengine::Suits::Oro),
      Tundengine::Ranks::Diez .de(Tundengine::Suits::Oro),
      Tundengine::Ranks::Cinco.de(Tundengine::Suits::Copa),
      Tundengine::Ranks::Diez .de(Tundengine::Suits::Copa),
      Tundengine::Ranks::Cinco.de(Tundengine::Suits::Espada),
      Tundengine::Ranks::Diez .de(Tundengine::Suits::Espada),
      Tundengine::Ranks::Cinco.de(Tundengine::Suits::Basto),
      Tundengine::Ranks::Diez. de(Tundengine::Suits::Basto)
    ])

    @@new_hand << Tundengine::Ranks::Dos.de(Tundengine::Suits::Copa)
    trick.play!(  Tundengine::Ranks::Dos.de(Tundengine::Suits::Copa))

    expected = [Tundengine::Hand.new([
      Tundengine::Ranks::Cinco.de(Tundengine::Suits::Copa),
      Tundengine::Ranks::Diez .de(Tundengine::Suits::Copa)
    ]), true]

    actual = hand.playable_cards(trick)

    assert_equal expected, actual
  end



end