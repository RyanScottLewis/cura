module Cura
  module Attributes
    # Adds the `update_attributes` method.
    module HasAttributes
      # Initialize this object by optionally updating attributes with a Hash.
      #
      # @param [#to_h] attributes Attributes to set after initializing.
      def initialize(attributes={})
        update_attributes(attributes)

        super
      end

      # Update any attributes on this object.
      #
      # @param [#to_h] attributes
      # @return [Hash] The attributes.
      def update_attributes(attributes={})
        attributes = convert_attributes(attributes)

        attributes.each { |name, value| send("#{name}=", value) }
      end

      protected

      VALID_SIZE_SYMBOLS = [:auto, :inherit]

      def validate_size_attribute(value)
        if value.is_a?(Symbol)
          raise ArgumentError, "must be one of #{VALID_SIZE_SYMBOLS.join(', ')}" unless VALID_SIZE_SYMBOLS.include?(value)
        else
          value = value.to_i
          value = 0 if value < 0
        end

        value
      end

      # Convert the attributes to a Hash and any other conversions that may need to happen.
      #
      # @param [#to_h] attributes
      # @return [Hash] The attributes.
      def convert_attributes(attributes={})
        attributes.to_h
      end
    end
  end
end
