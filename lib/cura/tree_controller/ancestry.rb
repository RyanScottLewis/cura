if Kernel.respond_to?(:require)
  require "cura/attributes/has_ancestry"
  require "cura/attributes/has_children"

  require "cura/helpers/validations"
end

module Cura
  class TreeController
    module Ancestry
      include Helpers::Validations

      # Creates a relation, or "edge", within a component view tree.
      def create_relation(parent, child)
        validate_type(parent, Attributes::HasApplication)
        validate_type(parent, Attributes::HasChildren)

        validate_type(child,  Attributes::HasAncestry)

        return [parent, child] if child.parent == parent && parent.has_child?(child)

        child.set_parent(parent) unless child.parent == parent
        parent.children << child unless parent.has_child?(child)
        parent.set_children(parent.children + [child]) unless parent.has_child?(child)

        child.root = parent.root.nil? ? parent : parent.root

        child.ancestors = find_ancestors(child)

        child.application = parent.application

        [parent, child]
      end

      protected

      def find_ancestors(node, memo=[])
        validate_type(node, Attributes::HasAncestry)

        return memo unless node.parent?

        memo << node.parent

        find_ancestors(node.parent, memo=[])
      end
    end
  end
end
