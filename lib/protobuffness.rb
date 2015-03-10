require "protobuffness/version"
require "protobuffness/enum"
require "protobuffness/string"
require "protobuffness/uint32"
require "protobuffness/wire_types"

module Protobuffness
  module Varint
    def self.encode(value)
      bytes = []
      until value < 128
        bytes << (0x80 | (value & 0x7f))
        value >>= 7
      end
      (bytes << value).pack('C*')
    end
  end
end
