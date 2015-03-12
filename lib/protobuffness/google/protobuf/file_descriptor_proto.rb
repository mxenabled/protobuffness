module Google
  module Protobuf
    class FileDescriptorProto
      def initialize(attributes)
        @attributes = {
          :dependency => [],
          :message_type => [],
          :enum_type => [],
          :service => [],
          :extension => [],
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

      def package
        @attributes[:package]
      end

      def package=(package)
        @attributes[:package] = package
      end

      def dependency
        @attributes[:dependency]
      end

      def dependency=(dependency)
        @attributes[:dependency] = dependency
      end

      def message_type
        @attributes[:message_type]
      end

      def message_type=(message_type)
        @attributes[:message_type] = message_type
      end

      def enum_type
        @attributes[:enum_type]
      end

      def enum_type=(enum_type)
        @attributes[:enum_type] = enum_type
      end

      def service
        @attributes[:service]
      end

      def service=(service)
        @attributes[:service] = service
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
        message = FileDescriptorProto.new({})
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
          message.package = value
        when 3
          message.dependency = value
        when 4
          message.message_type = DescriptorProto.decode(value)
        when 5
          message.enum_type = value
        when 6
          message.service = value
        when 7
          message.service = value
        when 8
          message.options = value
        end
      end
    end
  end
end
