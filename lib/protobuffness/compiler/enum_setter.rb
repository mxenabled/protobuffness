module Protobuffness
  class Compiler
    class EnumSetter < Setter
      def lines
        [
          "def #{field.name}=(#{field.name})",
          "  @attributes[:#{field.name}] = #{type_name}.lookup(#{field.name})",
          "end",
        ]
      end

      def type_name
        field.type_name[1..-1] # trim the leading . for fully-qualified names
      end
    end
  end
end
