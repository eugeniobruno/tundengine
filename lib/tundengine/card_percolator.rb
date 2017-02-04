module Tundengine
  module CardPercolator

    def percolate(cards, method = :select)
      cards.public_send(method) { |c| passes_card_percolator? c }
    end

  end
end