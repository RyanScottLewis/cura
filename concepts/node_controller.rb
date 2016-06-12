#!/usr/bin/env ruby

class NodeController

  def add_child(parent, child)
    child.parent = parent
    child.root = find_root(node)

    parent.children << child

    [parent, child]
  end

  def find_root(node)
    find_root(node.parent) unless node.parent.nil?

    node
  end

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
      traversed_nodes.each { |traversed_node| traversed_node.send("#{attribute}=", current_value) }

      current_value
    end
  end

end

class Node

  def initialize(app, color)
    @app = app
    @color = color.to_sym

    @root = nil
    @parent = nil
    @children = []
  end

  attr_accessor :root

  attr_accessor :parent

  attr_accessor :children

  attr_reader :color

  def color=(value)
    if value.nil?
      # TODO: THink through the logic on this one. What happens when the value is inherited, then the parent is changed?
      app.controller.inherit_attribute(self, :color)
    else
      @color = value
    end
  end

  def add_child(node)
    app.controller.add_child(self, node)

    self
  end

end

class Application

  def initialize
    @node_controller = NodeController.new
  end

  attr_reader :node_controller

end

root = Node.new
