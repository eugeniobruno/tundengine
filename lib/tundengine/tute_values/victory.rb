module Tundengine
  module TuteValues
    class Victory < Base

      include Singleton

      def finishes_round?
        true
      end

      def points_for_loser(loser, max_points)
        max_points - loser.match_points
      end

    end
  end
end