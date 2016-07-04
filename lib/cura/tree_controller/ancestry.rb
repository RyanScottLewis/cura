module Cura
  class TreeController
    module Ancestry
      def create_relation(parent, child)
        child.parent = parent unless child.parent == parent
        parent.children << child unless parent.has_child?(child)

        child.root = parent.root.nil? ? parent : parent.root
        child.ancestors = find_ancestors(child)

        [parent, child]
      end

      protected

      def find_ancestors(node)

      end

    end
  end
end
