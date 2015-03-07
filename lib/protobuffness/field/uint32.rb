module Protobuffness
  module Field
    class Uint32 < Base
      def prefix
        key = (order << 3) | WireType::VARINT
        ::Protobuffness.encode_varint(key)
      end

      def encode(value)
        ::Protobuffness.encode_varint(value)
      end
    end
  end
end
