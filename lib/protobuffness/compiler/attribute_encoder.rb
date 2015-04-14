module Protobuffness
  class Compiler
    class AttributeEncoder
      attr_reader :field

      def initialize(field)
        @field = field
      end

      def lines
        [
          "io << ::Protobuffness::#{type_class_string}.encode_attribute(@attributes[:#{field.name}], #{field.number})",
        ]
      end

      private

      def type_class_string
        case field.type.name
        when :TYPE_ENUM
          :Enum
        when :TYPE_STRING
          :String
        when :TYPE_UINT32
          :Uint32
        else
          fail ArgumentError, "unknown field type: #{field.type.name} :: #{field.type.tag}"
        end
      end
    end
  end
end
