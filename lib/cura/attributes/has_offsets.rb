if Kernel.respond_to?(:require)
  require 'cura/attributes/has_borders'
  require 'cura/attributes/has_margins'
  require 'cura/attributes/has_padding'
  require 'cura/offsets'
end

module Cura
  module Attributes
    
    # Adds the `offsets` attribute to objects.
    module HasOffsets
      
      include HasBorders
      include HasMargins
      include HasPadding
      
      def initialize(attributes={})
        @offsets = Offsets.new( component: self )
        
        super
      end
      
      # Get the offsets of this object.
      # 
      # @return [Offsets]
      attr_reader :offsets
      
    end
    
  end
end
