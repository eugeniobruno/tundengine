module Tundengine
  module Declarations
    class Void < Base

      include Singleton

      ROUND_POINTS = 0

      def is_declarable?(hand, trump_suit)
        true
      end

    end
  end
end