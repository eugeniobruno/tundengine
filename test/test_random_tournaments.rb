require 'minitest/autorun'
require 'tundengine'
require_relative './test_helper'

class TestRandomTournaments < Minitest::Test

  include TestHelper

  def test_three_players
    play_with 3
  end

  def test_four_players
    play_with 4
  end

  def test_five_players
    play_with 5
  end

  protected

  def play_with(number_of_players)
    setup!

    players    = @@players.take number_of_players
    tournament = Tundengine::Stages::Tournament.new(players, @@tournament_options)
    tournament.play!
  end

end