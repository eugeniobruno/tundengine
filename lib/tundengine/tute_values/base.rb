module Tundengine
  module TuteValues
    class Base

      include StringifiableByClass

      def has_effect?
        true
      end

      def finishes_round?
        false
      end

    end
  end
end