require 'tundengine'

module TestHelper

  def setup!(strategies = :all_automatic)
    strategy = Tundengine::Strategies::Random.new if strategies == :all_automatic
    strategy = Tundengine::Strategies::Manual.new if strategies == :all_manual

    @@all_ranks = Tundengine::Deck::RANKS
    @@all_suits = Tundengine::Deck::SUITS
    @@all_cards = Tundengine::Deck::CARDS

    @@players = %w(Mati Mar Pablito Mary Euge).map do |name|
      Tundengine::Player::InMatch.new(name, strategy)
    end

    @@tournament_options = {
      max_matches: 1,
      match_settings: {
        max_points: 4,
        tute_value: Tundengine::TuteValues::Nothing.instance,
        losing_position: :second # the alternative is :not_first_or_last
      }
    }

    @@new_tournament = Tundengine::Stages::Tournament.new(@@players, @@tournament_options)
    @@new_match      = @@new_tournament.current_match
    @@new_round      = @@new_match.current_round
    @@new_trick      = @@new_round.current_trick
    @@new_turn       = @@new_trick.current_turn
    @@new_player     = @@new_turn.player
    @@new_hand       = @@new_player.hand
  end

end