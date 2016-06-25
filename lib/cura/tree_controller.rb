module Cura
  class TreeController
    module Ancestry

      def add_child(parent, child)
        child.parent = parent
        child.root = find_root(parent)

        parent.children << child

        [parent, child]
      end

      def find_root(node)
        node.parent.nil? ? node : find_root(node.parent)
      end

      def find_ancestors(node)

      end

    end
  end
end

module Cura
  class TreeController
    module AttributeInheritence

      # Traverse the tree upwards until a node with the given attribute is non-empty, and setting the attribute to that
      # value to every node traversed.
      #
      # Logic flow:
      #   Add node to traversed_nodes
      #   Traverse upwards 1 node as current_node
      #   If attribute is non-empty
      #     Set the attribute on all traversed_nodes
      #   If attribute is empty
      #     Recurse with current_node
      #
      # @return [Object] The attribute's value.
      def inherit_attribute(node, attribute, traversed_nodes=[])
        attribute = attribute.to_sym

        traversed_nodes << node

        current_node = node.parent
        current_value = current_node.send(attribute)

        if current_value.nil?
          inherit_attribute(current_node, attribute, traversed_nodes)
        else
          traversed_nodes.each { |traversed_node| traversed_node.send("inherited_#{attribute}=", current_value) }

          current_value
        end
      end

      # Inherit all attributes.
      def inherit_attributes(node)
        node.class.attributes.each { |attribute| inherit_attribute(node, attribute) }
      end

      # Pass on an attribute from a node to all of it's children.
      def bestow_attribute(node, attribute, value=nil)
        return value if node.children.empty?

        attribute = attribute.to_sym

        value = node.send(attribute) if value.nil?
        node.children.each { |child| child.send("inherited_#{attribute}=", value) }

        value
      end

    end
  end
end

require "cura/tree_controller/ancestry"
require "cura/tree_controller/attribute_inheritence"

module Cura
  # Controls a component view tree.
  #
  # Effectively decouples nodes, preventing them from controlling the internal state of other nodes.
  class TreeController
    include Ancestry
    include AttributeInheritence
  end

end
