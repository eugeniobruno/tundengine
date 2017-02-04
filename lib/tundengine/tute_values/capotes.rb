module Tundengine
  module TuteValues
    class Capotes < Base

      include AlgebraicDataType

      def initialize(points)
        @points = points
        super()
      end

      def points_for_loser(loser, max_points)
        [@points, max_points].min
      end

      def identifier
        [@points]
      end

    end
  end
end