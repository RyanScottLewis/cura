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
