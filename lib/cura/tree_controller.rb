if Kernel.respond_to?(:require)
  require "cura/tree_controller/ancestry"
  require "cura/tree_controller/attribute_inheritence"
end

module Cura
  # Controls a component view tree.
  #
  # Effectively decouples nodes, preventing them from controlling the internal state of other nodes.
  # The trade off is more method calls during creation and modification of components, but faster
  # drawing.
  class TreeController
    include Ancestry
    include AttributeInheritence
  end
end
