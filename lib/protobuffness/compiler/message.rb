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
        define_class do
          define_initializer << define_attribute_methods
        end
      end

      def define_attribute_methods
        message_type.field.map do |field|
          define_methods_for(field)
        end.flatten
      end

      def define_class
        ["class #{message_type.name}"] << yield << ["end"]
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
    end
  end
end
