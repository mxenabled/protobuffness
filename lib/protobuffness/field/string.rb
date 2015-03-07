module Protobuffness
  module Field
    class String
      attr_reader :name, :order, :rule

      def initialize(rule, name, order)
        @rule = rule
        @name = name
        @order = order
      end

      def prefix
        key = (order << 3) | WireType::LENGTH_DELIMITED
        Protobuffness.encode_varint(key)
      end

      def encode(value)
        value_to_encode = value.dup
        value_to_encode.encode!(Encoding::UTF_8, :invalid => :replace, :undef => :replace, :replace => "")
        value_to_encode.force_encoding(Encoding::BINARY)

        string_size = Protobuffness.encode_varint(value_to_encode.size)
        string_size << value_to_encode
      end
    end
  end
end
