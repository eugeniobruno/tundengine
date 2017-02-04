module Tundengine
  module Stages
    class Round < Base

      extend Forwardable
      def_delegator  :@parent, :max_points, :max_match_points
      def_delegators :@parent, :tute_value, :losing_position

      attr_reader :players, :trump_suit, :last_declaration

      LAST_TRICK_BONUS_POINTS = 10

      def initialize(match, players_in_round, trump_suit)
        @players = players_in_round
        @players.each { |p| p.round = self }
        @trump_suit = trump_suit.freeze
        @last_declaration = Declarations::Null.instance
        super(match)
        Dealer.instance.deal!(players, trump_suit)
      end

      alias_method :match, :parent
      alias_method :tricks, :children
      alias_method :current_trick, :child_in_play

      def declare!(declaration = Declarations::Null.instance)
        last_winner_player.declare!(declaration)
      end

      def on_complete_child! # when the current trick is completed
        super
        rotate_players!
      end

      def on_completed!
        last_winner_player.bonus_points = LAST_TRICK_BONUS_POINTS
        parent.on_complete_child!(result)
      end

      def after_declaring!(declaration)
        current_trick.after_declaring!(declaration)
        @last_declaration = declaration
      end

      def summary
        {
          trump_suit: trump_suit.to_s,
          players: players.map(&:summary)
        }
      end

      protected

      def new_child
        Trick.new(self)
      end

      def rotate_players!
        players.rotate!(players.index next_first_player)
      end

      def last_winner_player
        last_trick.winner_player
      end
      alias_method :next_first_player, :last_winner_player

      def last_trick
        tricks.last || :no_trick
      end

      def completed?
        any_player.has_empty_hand? or @last_declaration.finishes_round?(tute_value)
      end

      def any_player
        players.first
      end

      def result
        RoundAnalyzer.new(self).result
      end

    end
  end
end