module Tundengine
  module Stages
    class Trick < Base

      extend Forwardable
      def_delegator  :@winner_turn, :player_in_round, :winner_player
      def_delegator  :@winner_turn, :card,            :winner_card
      def_delegators :@parent, :players, :trump_suit

      include CardPercolator

      attr_reader :declaration

      def initialize(round)
        @next_player_index = 0
        super
        @winner_turn = current_turn
        @declaration = :no_declaration
      end

      alias_method :round, :parent
      alias_method :turns, :children
      alias_method :current_turn, :child_in_play

      def on_complete_child!(beats) # when the current turn is completed
        @winner_turn = current_turn if beats
        super()
      end

      def after_declaring!(declaration)
        @declaration = declaration
        on_completed_with_declaration!
      end

      def first_suit
        cards.fetch(0, Cards::Null.instance).suit
      end

      def points
        cards.reduce(0) { |acum, card| acum + card.round_points }
      end

      def cards
        turns.map(&:card)
      end

      def next_player # in round
        players.fetch(@next_player_index - 1)
      end

      def summary
        {
          cards: cards.map(&:to_s),
          winner_player: winner_player.name,
          winner_card:   winner_card.to_s,
          declaration:   declaration.to_s,
        }
      end

      protected

      def new_child
        Turn.new(self)
      end

      def new_child_in_play! # before starting a new turn
        @next_player_index += 1
        super
      end

      def completed?
        turns.length == players.length
      end

      def on_completed!
        winner_player.on_winning_trick!(self)
      end

      def on_completed_with_declaration!
        round.on_complete_child!
      end

      def is_taken_by?(card)
        card.beats? winner_card, trump_suit
      end
      alias_method :passes_card_percolator?, :is_taken_by?

    end
  end
end