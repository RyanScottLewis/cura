module Cura
  module Widget
    
    # TODO: Option to have buttons or not
    class Scrollbar < Group
      
      include Attributes::HasOrientation
      
      def initialize(attributes={})
        @value = 0
        @min, @max = 0, 100
        @orientation = :vertical
        @buttons = {}
        
        @buttons[:decrement] = Button.new( width: 1, height: 1 ) { parent.decrement }
        @buttons[:increment] = Button.new( width: 1, height: 1 ) { parent.increment }
        @handle = Widget.new( width: 1, height: 1 )
        
        super
        
        setup_value
        setup_buttons
        setup_handle
        
        set_button_labels_based_on_orientation
        set_button_coordinates_based_on_orientation
        set_percentage
        set_handle_position
      end
      
      # Get the buttons for this widget.
      attr_reader :buttons
      
      # Get the value of this widget.
      attr_reader :value
      
      # Set the value of this widget.
      def value=(value)
        raise ArgumentError, "value must respond to :to_i" unless value.respond_to?(:to_i)
        
        value = max if value > max
        value = min if value < min
        
        @value = value.to_i
        
        set_percentage
        set_handle_position
      end
      
      # Get the percentage of this widget.
      attr_reader :percent
      
      # Set the width of this widget.
      def width=(value)
        super
        
        # @width = 2 if @width == 0 # TODO: Depends on if buttons are shown or not AND orientation
        
        set_button_coordinates_based_on_orientation
      end
      
      # Set the height of this widget.
      def height=(value)
        super
        
        # @height = 2 if @height == 0 # TODO: Depends on if buttons are shown or not AND orientation
        
        set_button_coordinates_based_on_orientation
      end
      
      # Get the minimum value of this widget.
      attr_reader :min
      
      # Set the minimum value of this widget.
      def min=(value)
        raise ArgumentError, "min must respond to :to_i" unless value.respond_to?(:to_i)
        
        @min = value.to_i
      end
      
      # Get the maximum value of this widget.
      attr_reader :max
      
      # Set the maximum value of this widget.
      def max=(value)
        raise ArgumentError, "max must respond to :to_i" unless value.respond_to?(:to_i)
        
        @max = value.to_i
      end
      
      # Set the orientation of this widget.
      def orientation=(value)
        super
        
        set_button_labels_based_on_orientation
      end
      
      # Increment the value of this widget by the given number (default: 1).
      def increment(value=1)
        raise ArgumentError, "value must respond to :to_i" unless value.respond_to?(:to_i)
        
        self.value += value.to_i
      end
      
      # Decrement the value of this widget by the given number (default: 1).
      def decrement(value=1)
        raise ArgumentError, "value must respond to :to_i" unless value.respond_to?(:to_i)
        
        self.value -= value.to_i
      end
      
      protected
      
      def setup_value
        @value = min if value < min
        @value = max if value > max
      end
      
      def setup_buttons
        @buttons.each do |name, button|
          button.foreground = foreground
          button.background = background
          
          add(button)
        end
      end
      
      def setup_handle
        @handle.foreground = background
        @handle.background = foreground
        
        add(@handle)
      end
      
      def set_button_labels_based_on_orientation
        if vertical?
          @buttons[:decrement].text = "˄"
          @buttons[:increment].text = "˅"
        elsif horizontal?
          @buttons[:decrement].text = "˂"
          @buttons[:increment].text = "˃"
        end
      end
      
      def set_button_coordinates_based_on_orientation
        if vertical?
          @buttons[:increment].x = 0
          @buttons[:increment].y = height-1
        elsif horizontal?
          @buttons[:increment].x = width-1
          @buttons[:increment].y = 0
        end
      end
      
      def set_percentage
        @percent = ( (value.to_f - min.to_f) / (max.to_f - min.to_f) * 100.0 ).to_i
      end
      
      def set_handle_position
        # TODO: Only +/- padding when buttons are shown
        dimension = (vertical? ? height : width) - 3
        position = (dimension.to_f * percent.to_f / 100.0).to_i + 1
        
        if vertical?
          @handle.x = 0
          @handle.y = position
        elsif horizontal?
          @handle.x = position
          @handle.y = 0
        end
      end
      
    end
    
  end
end
