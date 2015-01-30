module Cura
  module Attributes
    
    # Adds the `offsets` attribute to objects.
    module HasOffsets
      
      include Attributes::HasBorders
      include Attributes::HasMargins
      include Attributes::HasPadding
      
      def initialize(attributes={})
        super
        
        @offsets = Offsets.new( widget: self )
      end
      
      # Get the offsets of this widget.
      # 
      # @return [Offsets]
      attr_reader :offsets
      
    end
    
  end
end
