module Tundengine
  module Cards
    class Null < Card

      include Singleton
      include NullMove

      def initialize
        super(Ranks::Null.instance, Suits::Null.instance)
      end

      def exists?
        false
      end

    end
  end
end