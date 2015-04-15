module Protobuffness
  class Compiler
    class Enum
      attr_reader :enum_descriptor

      def initialize(enum_descriptor)
        @enum_descriptor = enum_descriptor
      end

      def definition
        [
          "class #{enum_descriptor.name}",
          "  VALUES_BY_LABEL = {",
        ]
        .concat(values_by_label)
        .concat([
          "  }.freeze",
          "",
          "  VALUES_BY_TAG = VALUES_BY_LABEL.invert.freeze",
          "",
          "  def self.lookup(value)",
          "    return value if value.is_a?(#{name})",
          "    return new(value) if value.is_a?(Symbol)",
          "    label = VALUES_BY_TAG.fetch(value) { raise ArgumentError, \"unknown #{name} value: \#{value}\" }",
          "    return new(label)",
          "  end",
          "",
          "  attr_reader :label, :tag",
          "",
          "  def initialize(label)",
          "    raise ArgumentError, \"unknown #{name} value: \#{label}\" unless VALUES_BY_LABEL.keys.include?(label)",
          "    @label = label",
          "    @tag = VALUES_BY_LABEL[label]",
          "  end",
          "",
          "  def ==(other)",
          "    [label,tag] == [other.label, other.tag]",
          "  end",
          "",
          "  def eql?(other)",
          "    [self.class,label,tag] == [other.class, other.label, other.tag]",
          "  end",
          "end",
        ])
      end

      private

      def name
        enum_descriptor.name
      end

      def values_by_label
        enum_descriptor.value.map do |enum_value|
          "    :#{enum_value.name} => #{enum_value.number},"
        end
      end
    end
  end
end
