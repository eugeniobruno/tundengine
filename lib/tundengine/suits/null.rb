module Tundengine
  module Suits
    class Null < Base

      protected

      def is_of_this_suit?(card)
        true
      end
      alias_method :passes_card_percolator?, :is_of_this_suit?

    end
  end
end