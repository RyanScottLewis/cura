module Cura
  
  # The container for Event::Base and it's subclasses.
  module Event
    class << self
      
      # Get all Event::Base subclasses.
      #
      # @return [Array<Class>]
      def all
        @all ||= []
      end
      
      # Find an Event::Base subclass by it's name.
      #
      # @param [#to_sym] name The name of the event. For example, `SomeAction` would be `:some_action`.
      # @return [nil, Class] The Event::Base subclass.
      def find_by_name(name)
        name = name.to_sym
        
        all.find { |event_class| event_class.name == name }
      end
      
      # Initialize an Event::Base subclass by it's name.
      #
      # @param [#to_sym] name The name of the event class.
      def new_from_name(name, attributes={})
        # TODO: name should be a string formatted like so 'mouse:button:down' which would correspond to Cura::Event::Mouse::Button::Down
        event_class = find_by_name(name)
        raise ArgumentError, "Unknown event name '#{name}'" if event_class.nil?
        
        event_class.new(attributes)
      end
      
    end # << self
  end
  
end
