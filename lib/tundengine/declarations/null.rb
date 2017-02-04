module Tundengine
  module Declarations
    class Null

      include Singleton
      include NullMove

      def has_tute_effect?(tute_value)
        false
      end

      def finishes_round?(tute_value)
        false
      end

    end
  end
end