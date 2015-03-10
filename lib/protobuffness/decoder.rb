module Protobuffness
  module Decoder

    # Read bytes from +stream+ and pass to +message+ object.
    def self.decode_each_field(stream, &block)
      until stream.eof?
        tag, bytes = read_field(stream)
        block.call(tag, bytes)
      end
    end

    def self.read_field(stream)
      tag, wire_type = read_key(stream)
      bytes = case wire_type
              when ::Protobuffness::WireTypes::VARINT then
                read_varint(stream)
              when ::Protobuffness::WireTypes::FIXED64 then
                read_fixed64(stream)
              when ::Protobuffness::WireTypes::LENGTH_DELIMITED then
                read_length_delimited(stream)
              when ::Protobuffness::WireTypes::FIXED32 then
                read_fixed32(stream)
              when ::Protobuffness::WireTypes::START_GROUP then
                fail NotImplementedError, 'Group is deprecated.'
              when ::Protobuffness::WireTypes::END_GROUP then
                fail NotImplementedError, 'Group is deprecated.'
              else
                fail InvalidWireType, wire_type
              end

      [tag, bytes]
    end

    # Read 32-bit string value from +stream+.
    def self.read_fixed32(stream)
      stream.read(4)
    end

    # Read 64-bit string value from +stream+.
    def self.read_fixed64(stream)
      stream.read(8)
    end

    # Read key pair (tag and wire-type) from +stream+.
    def self.read_key(stream)
      bits = read_varint(stream)
      wire_type = bits & 0x07
      tag = bits >> 3
      [tag, wire_type]
    end

    # Read length-delimited string value from +stream+.
    def self.read_length_delimited(stream)
      value_length = read_varint(stream)
      stream.read(value_length)
    end

    # Read varint integer value from +stream+.
    def self.read_varint(stream)
      value = index = 0
      begin
        byte = stream.readbyte
        value |= (byte & 0x7f) << (7 * index)
        index += 1
      end while (byte & 0x80).nonzero?
      value
    end

  end
end
