module Google
  module Protobuf
    class DescriptorProto
      def initialize(attributes = {})
        @attributes = {
          :field => [],
          :extension => [],
          :nested_type => [],
          :enum_type => [],
          :extension_range => [],
          :oneof_decl => [],
        }
        attributes.each do |attribute, value|
          public_send("#{attribute}=", value)
        end
      end

      def name
        @attributes[:name]
      end

      def name=(name)
        @attributes[:name] = name
      end

      def field
        @attributes[:field]
      end

      def field=(field)
        @attributes[:field] = field
      end

      def extension
        @attributes[:extension]
      end

      def extension=(extension)
        @attributes[:extension] = extension
      end

      def nested_type
        @attributes[:nested_type]
      end

      def nested_type=(nested_type)
        @attributes[:nested_type] = nested_type
      end

      def enum_type
        @attributes[:enum_type]
      end

      def enum_type=(enum_type)
        @attributes[:enum_type] = enum_type
      end

      def extension_range
        @attributes[:extension_range]
      end

      def extension_range=(extension_range)
        @attributes[:extension_range] = extension_range
      end

      def oneof_decl
        @attributes[:oneof_decl]
      end

      def oneof_decl=(oneof_decl)
        @attributes[:oneof_decl] = oneof_decl
      end

      def options
        @attributes[:options]
      end

      def options=(options)
        @attributes[:options] = options
      end

      ## Decoding

      def self.decode(bytestring)
        stream = StringIO.new(bytestring)
        decode_from_stream(stream)
      end

      def self.decode_from_stream(stream)
        message = new({})
        Protobuffness::Decoder.decode_each_field(stream) do |tag, value|
          assign_field_to_message(tag, value, message)
        end
        message
      end

      def self.assign_field_to_message(tag, value, message)
        case tag
        when 1
          message.name = value
        when 2
          message.field = FieldDescriptorProto.decode(value)
        when 3
          message.nested_type = value
        when 4
          message.enum_type = value
        when 5
          message.extension_range = value
        when 6
          message.extension = value
        when 7
          message.options = value
        end
      end
    end
  end
end
