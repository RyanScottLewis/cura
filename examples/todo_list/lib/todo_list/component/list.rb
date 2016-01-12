module TodoList
  module Component
    
    class List < Cura::Component::Pack
      
      on_event(:focus) do |event|
        @textbox.focus if event.target == self
      end
      
      def initialize(attributes={})
        attributes = { orientation: :horizontal }.merge(attributes)
        
        super(attributes)
        
        raise ArgumentError, "model cannot be nil" if @model.nil?
        raise ArgumentError, "listbox cannot be nil" if @listbox.nil?
        
        setup_components
      end
      
      attr_accessor :model
      
      attr_accessor :listbox
      
      attr_reader :textbox
      
      protected
      
      def setup_components
        setup_textbox
      end
      
      def setup_textbox
        @textbox = Cura::Component::Textbox.new(text: @model.text, width: width - 2, background: :inherit, foreground: :inherit, focusable: false)
        @textbox.on_event(:key_down, @listbox, @model) do |event, listbox, model|
          if event.name == :enter
            model.text = text
            model.save
            
            listbox.focus
          end
        end
        
        add_child(@textbox)
      end
      
    end
    
  end
end
