module Tundengine
  module Suits
    class Base

      include Singleton
      include StringifiableByClass
      include CardPercolator

      protected

      def is_of_this_suit?(card)
        card.suit == self
      end
      alias_method :passes_card_percolator?, :is_of_this_suit?

    end
  end

end