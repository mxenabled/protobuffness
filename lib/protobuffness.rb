require "protobuffness/version"
require "protobuffness/schema"
require "protobuffness/field/string"
require "protobuffness/wire_type"

module Protobuffness
  def self.encode(values, schema)
    stream = ::StringIO.new
    stream.set_encoding(Encoding::BINARY)
    values.each do |key, value|
      field = schema.field_for(key)
      stream << field.prefix
      stream << field.encode(value)
    end
    stream.string
  end

  def self.encode_varint(value)
    bytes = []
    until value < 128
      bytes << (0x80 | (value & 0x7f))
      value >>= 7
    end
    (bytes << value).pack('C*')
  end
end
