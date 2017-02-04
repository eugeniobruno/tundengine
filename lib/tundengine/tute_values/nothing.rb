module Tundengine
  module TuteValues
    class Nothing < Base

      include Singleton

      def has_effect?
        false
      end

    end
  end
end