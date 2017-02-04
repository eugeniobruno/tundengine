module Tundengine
  module Stages
    class Tournament < Base

      SETTINGS_KEYS = %i(max_matches match_settings)
      # TODO: Add a setting to run matches on multiple threads.

      attr_reader :players, :settings

      def initialize(players, settings)
        @players  = players
        @settings = settings
        @result   = initial_result
        super()
      end

      alias_method :matches, :children
      alias_method :current_match, :child_in_play

      SETTINGS_KEYS.each do |key|
        define_method key do
          settings.fetch key
        end
      end

      def on_complete_child!(result)
        update_result!(result)
        super()
      end

      def summary
        {
          players: players.map(&:name),
          result: @result.each_with_object({}) { |(k,v),h| h[k.to_s] = v }
        }
      end

      protected

      def initial_result
        @players.each_with_object({}) { |p, h| h[p] = 0 }
      end

      def new_child
        Match.new(self, @players, match_settings)
      end

      # TODO: Implement different ways to accumulate match results.
      def update_result!(match_result)
        @result.merge! match_result do |_, tournament_score, match_score|
          tournament_score + match_score
        end
      end

      # TODO: Implement different criteria for finishing tournaments.
      def completed?
        matches.length == max_matches
      end

      def on_completed!
        # for debugging purposes
        # puts 'Tournament completed. As hash:'
        # p as_hash
      end

      def children_key_name
        :matches
      end

    end
  end
end