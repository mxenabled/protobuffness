module Protobuffness
  class Compiler
    class Message
      attr_reader :message_type

      def initialize(message_type)
        @message_type = message_type
      end

      def message_definition
        compile
      end

      private

      def compile
        define_class do |lines|
          lines.indent(define_initializer)
          lines.indent(define_attribute_methods)
          lines.indent(define_encode_method)
        end
      end

      def define_attribute_methods
        message_type.field.map do |field|
          define_methods_for(field)
        end.flatten
      end

      def define_class
        lines = ["class #{message_type.name}"]
        yield(lines)
        lines << ["end"]
      end

      def define_initializer
        [
          "def initialize",
          "  @attributes = {}",
          "end"
        ]
      end

      def define_methods_for(field)
        [
          "def #{field.name}",
          "  @attributes[:#{field.name}]",
          "end",
          "",
          "def #{field.name}=(#{field.name})",
          "  @attributes[:#{field.name}] = #{field.name}",
          "end",
        ]
      end

      def define_encode_method
        [
          "def encode",
          "  ::Protobuffness::String.encode_attribute(@attributes[:mood], 1)",
          "  ::Protobuffness::Uint32.encode_attribute(@attributes[:age], 2)",
          "end",
        ]
      end
    end
  end
end
