if Kernel.respond_to?(:require)
  require "cura/event/mouse"
end

module Cura
  module Event
    
    # Dispatched when a mouse's button state changes.
    class MouseButton < Mouse
      
      VALID_NAMES = [:left, :middle, :right]
      VALID_STATES = [:up, :down, :click, :double_click]
      
      def initialize(attributes={})
        super
        
        # raise ArgumentError, "name must be set" if @name.nil? # TODO: Termbox doesn't support which button was released yet
        raise ArgumentError, "state must be set" if @state.nil?
      end
      
      # @method state
      # Get the mouse button state.
      # Will return `:up`, `:down`, `:click`, or `:double_click`.
      #
      # @return [Symbol]
      
      # @method state=(value)
      # Set the mouse button state.
      #
      # @param [#to_sym] value
      # @return [Symbol]
      
      attribute(:state) { |value| validate_list(value, VALID_STATES) }
      
      # @method name
      # Get the mouse button name.
      # Will return `:left`, `:middle`, or `:right`.
      #
      # @return [Symbol]
      
      # @method name=(value)
      # Set the mouse button name.
      #
      # @param [#to_sym] value
      # @return [Symbol]
      
      attribute(:name) { |value| validate_list(value, VALID_NAMES) }
      
      # @method left?
      # Get whether the mouse button state occurred the left button.
      #
      # @return [Boolean]
      
      # @method middle?
      # Get whether the mouse button state occurred the middle button.
      #
      # @return [Boolean]
      
      # @method right?
      # Get whether the mouse button state occurred the right button.
      #
      # @return [Boolean]
      
      VALID_NAMES.each do |name|
        define_method("#{name}?") { @name == name }
      end
      
      # @method up?
      # Get whether the mouse button state is up.
      #
      # @return [Boolean]
      
      # @method down?
      # Get whether the mouse button state is down.
      #
      # @return [Boolean]
      
      # @method click?
      # Get whether the mouse button state is click.
      #
      # @return [Boolean]
      
      # @method click?
      # Get whether the mouse button state is double_click.
      #
      # @return [Boolean]
      
      VALID_STATES.each do |state|
        define_method("#{state}?") { @state == state }
      end
      
      protected
      
      def validate_list(value, list)
        raise ArgumentError, "must be one of #{list.join(', ')}" unless list.include?(value)
        
        value.to_sym
      end
      
    end
    
  end
end
