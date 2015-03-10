module Protobuffness
  module Enum
    def self.encode(enum)
      Varint.encode(enum.tag)
    end

    def self.encode_attribute(enum, tag)
      encode_prefix(tag) << encode(enum)
    end

    def self.encode_prefix(tag)
      key = (tag << 3) | WireTypes::VARINT
      Varint.encode(key)
    end
  end
end
