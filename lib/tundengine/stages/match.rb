module Tundengine
  module Stages
    class Match < Base

      SETTINGS_KEYS = %i(max_points tute_value losing_position)

      attr_reader :settings

      def initialize(tournament, players, settings)
        @players  = players
        @settings = settings
        @trumps   = Deck::SUITS.dup
        @result   = @players.each_with_object({}) { |k, h| h[k] = 0 }
        super(tournament)
      end

      alias_method :tournament, :parent
      alias_method :rounds, :children
      alias_method :current_round, :child_in_play

      SETTINGS_KEYS.each do |key|
        define_method key do
          settings.fetch key
        end
      end

      def on_complete_child!(result)
        update_result!(result)
        rotate_trumps_and_players!
        super()
      end

      def on_completed!
        tournament.on_complete_child!(@result)
      end

      def summary
        {
          settings: settings.each_with_object({}) { |(k,v),h| h[k.to_s] = v.to_s },
          players: @players.map(&:name),
          result:  @result.each_with_object({}) { |(k,v),h| h[k.to_s] = v }
        }
      end

      protected

      def new_child
        Round.new(self, players_for_new_round, trump_for_new_round)
      end

      def players_for_new_round
        @players.map(&:in_new_round)
      end

      def trump_for_new_round
        @trumps.first
      end

      def update_result!(round_result)
        # these are all match scores, not round points
        @result.merge!(round_result) do |_, acum_score, last_round_score|
          acum_score + last_round_score
        end
      end

      def rotate_trumps_and_players!
        [@trumps, @players].each { |a| a.rotate! 1 }
      end

      def completed?
        not losers.empty?
      end

      def losers
        @result.select { |_, points| points >= max_points }
      end

    end
  end
end