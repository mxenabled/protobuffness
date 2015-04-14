module Protobuffness
  module Uint32
    def self.encode(value)
      Varint.encode(value)
    end

    def self.encode_attribute(value, tag)
      encode_prefix(tag) << encode(value)
    end

    def self.encode_prefix(tag)
      key = (tag << 3) | WireTypes::VARINT
      Varint.encode(key)
    end
  end
end
