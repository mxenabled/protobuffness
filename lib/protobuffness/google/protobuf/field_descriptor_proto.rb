module Google
  module Protobuf
    class FieldDescriptorProto
      def initialize(attributes)
        @attributes = {}
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

      def number
        @attributes[:number]
      end

      def number=(number)
        @attributes[:number] = number
      end

      def label
        @attributes[:label]
      end

      def label=(label)
        @attributes[:label] = label
      end

      def type
        @attributes[:type]
      end

      def type=(type)
        @attributes[:type] = type
      end

      def type_name
        @attributes[:type_name]
      end

      def type_name=(type_name)
        @attributes[:type_name] = type_name
      end

      def extendee
        @attributes[:extendee]
      end

      def extendee=(extendee)
        @attributes[:extendee] = extendee
      end

      def default_value
        @attributes[:default_value]
      end

      def default_value=(default_value)
        @attributes[:default_value] = default_value
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
          message.extendee = value
        when 3
          message.number = value
        when 4
          message.label = value
        when 5
          message.type = value
        when 6
          message.type_name = value
        when 7
          message.default_value = value
        when 8
          message.options = value
        end
      end
    end
  end
end
