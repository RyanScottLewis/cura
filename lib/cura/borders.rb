if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_side_attributes'
end

module Cura
  
  class Borders
    
    class << self
      
      # TODO: attr_writer_colors (#left_foreground, etc.)
      
      def attr_writer_character(*names)
        names.each do |name|
          name = "#{name}_character".to_sym
          
          define_method( name ) do |value|
            instance_variable_set( "@#{name}", value.to_s[0] )
          end
        end
      end
      
      def attr_accessor_character(*names)
        attr_reader(*names)
        attr_writer_character(*names)
      end
    end
    
    include Attributes::HasInitialize
    include Attributes::HasSideAttributes
    # include Attributes::HasForegroundAndBackground
    
    def initialize(attributes={})
      @top_character,    @top_right_character    = ?-, ?+
      @right_character,  @bottom_right_character = ?|, ?+
      @bottom_character, @bottom_left_character  = ?-, ?+
      @left_character,   @top_left_character     = ?|, ?+
      
      super
    end
    
    attr_accessor_character :top, :top_right, :right, :bottom_right, :bottom, :bottom_left, :left, :top_left
    
  end
  
end
