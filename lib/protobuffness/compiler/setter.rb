module Protobuffness
  class Compiler
    class Setter
      def self.define_for(field)
        type_class = case field.type.name
                     when :TYPE_ENUM
                       EnumSetter
                     else
                       self
                     end
        type_class.new(field).lines
      end

      attr_reader :field

      def initialize(field)
        @field = field
      end

      def lines
        [
          "def #{field.name}=(#{field.name})",
          "  @attributes[:#{field.name}] = #{field.name}",
          "end",
        ]
      end
    end
  end
end

require 'protobuffness/compiler/enum_setter'
