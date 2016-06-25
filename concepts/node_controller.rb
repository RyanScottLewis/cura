#!/usr/bin/env ruby

class NodeController

  def add_child(parent, child)
    child.parent = parent
    child.root = find_root(parent)

    parent.children << child

    [parent, child]
  end

  def find_root(node)
    node.parent.nil? ? node : find_root(node.parent)
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


class Node

  class << self

    def attributes
      @attributes ||= [:color]
    end

  end

  def initialize(app, color=nil)
    @app = app

    @root = nil
    @parent = nil
    @children = []

    self.color = color unless color.nil?
  end

  attr_accessor :root

  attr_reader :parent

  def parent=(value)
    @parent = value

    @app.node_controller.inherit_attributes(self)

    @parent
  end

  attr_accessor :children

  attr_accessor :inherited_color

  def color
    return @inherited_color if @color.nil?

    @color
  end

  def color=(value)
    if value.nil?
      @app.node_controller.inherit_attribute(self, __method__)
    else
      @color = value

      @app.node_controller.bestow_attribute(self, __method__, value)
    end
  end

  def add_child(node)
    @app.node_controller.add_child(self, node)

    self
  end

end

class Application

  def initialize
    @node_controller = NodeController.new
  end

  attr_reader :node_controller

end

app = Application.new

root = Node.new(app, "blue")
grandparent = Node.new(app)
parent_a = Node.new(app, "red")
child_a_1 = Node.new(app)
child_a_2 = Node.new(app)
parent_b = Node.new(app, "green")
child_b_1 = Node.new(app)
child_b_2 = Node.new(app)
child_b_3 = Node.new(app, "seafoamgreen")

root.add_child(grandparent)
grandparent.add_child(parent_a)
parent_a.add_child(child_a_1)
parent_a.add_child(child_a_2)
grandparent.add_child(parent_b)
parent_b.add_child(child_b_1)
parent_b.add_child(child_b_2)
parent_b.add_child(child_b_3)

# "Tests"
puts root.color == "blue"
puts grandparent.color == "blue"
puts parent_a.color == "red"
puts child_a_1.color == "red"
puts child_a_2.color == "red"
puts parent_b.color == "green"
puts child_b_1.color == "green"
puts child_b_2.color == "green"
puts child_b_3.color == "seafoamgreen"

puts grandparent.root == root
puts parent_a.root == root
puts child_a_1.root == root
puts child_a_2.root == root
puts parent_b.root == root
puts child_b_1.root == root
puts child_b_2.root == root
puts child_b_3.root == root
