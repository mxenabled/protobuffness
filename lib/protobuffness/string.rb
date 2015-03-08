module Protobuffness
  module String
    def self.encode(string)
      string = string.dup
      string.encode!(Encoding::UTF_8, :invalid => :replace, :undef => :replace, :replace => "")
      string.force_encoding(Encoding::BINARY)
      length = Varint.encode(string.size)
      length << string
    end

    def self.encode_attribute(string, tag)
      encode_prefix(tag) << encode(string)
    end

    def self.encode_prefix(tag)
      key = (tag << 3) | WireTypes::LENGTH_DELIMITED
      Varint.encode(key)
    end
  end
end
