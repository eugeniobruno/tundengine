module Tundengine
  module StringifiableByClass

    def to_s
      self.class.name.split('::').last
    end

  end
end