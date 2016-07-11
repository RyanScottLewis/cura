module Cura
  module Helpers
    # Protected object conversion methods.
    module Conversions
      def convert_instance(value, type)
        value ||= {}

        value.is_a?(type) ? value : type.new(value)
      end

      def convert_array_instances(values, type)
        values.to_a.find_all { |value| convert_instance(value, type) }.freeze
      end
    end
  end
end
