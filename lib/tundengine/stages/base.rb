module Tundengine
  module Stages
    class Base

      attr_reader :parent, :children, :child_in_play

      def initialize(parent = Null.instance)
        @parent   = parent
        @children = []
        @rewinded = []
        new_child_in_play!
        @locked = false
      end

      def declare!(declaration = Declarations::Null.instance)
        child_in_play.declare!(declaration)
      end

      def play!(card = Cards::Null.instance)
        completed = completed?
        until completed or @locked
          child_in_play.play!(card)
          card = Cards::Null.instance
          completed = completed?
          completed ? on_completed! : new_child_in_play!
        end
        @locked = false
        block_given? ? (yield self) : self
      end

      def on_complete_child!
        children << child_in_play
      end

      def lock!
        @locked = true
        parent.lock!
      end

      def rewind!(n)
        [n, children.length].min.times { @rewinded.unshift(children.pop) }
      end

      def fast_forward!(n)
        [n, @rewinded.length].min.times { children.push(@rewinded.shift) }
      end

      def as_hash
        summary.merge(
          children_key_name => children.map(&:as_hash)
        )
      end

      protected

      def new_child_in_play!
        @child_in_play = new_child
      end

      def summary
        {}
      end

      def children_key_name
        "#{child_class_name}s".to_sym
      end

      def child_class_name
        children.first.class.name.split('::').last.downcase
      end

    end
  end
end