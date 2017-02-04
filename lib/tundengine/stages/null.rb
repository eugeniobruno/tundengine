module Tundengine
  module Stages
    class Null

      include Singleton

      def lock!
        # do nothing
      end

    end
  end
end