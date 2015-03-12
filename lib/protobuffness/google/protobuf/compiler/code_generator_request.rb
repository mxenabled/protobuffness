module Google
  module Protobuf
    module Compiler
      class CodeGeneratorRequest
        def initialize(attributes)
          @attributes = {
            :file_to_generate => [],
            :proto_file => [],
          }
          attributes.each do |attribute, value|
            public_send("#{attribute}=", value)
          end
        end

        ## Attributes

        def file_to_generate
          @attributes[:file_to_generate]
        end

        def file_to_generate=(file_to_generate)
          @attributes[:file_to_generate] = file_to_generate
        end

        def proto_file
          @attributes[:proto_file]
        end

        def proto_file=(proto_file)
          @attributes[:proto_file] = proto_file
        end

        ## Decoding

        def self.decode(bytestring)
          stream = StringIO.new(bytestring)
          decode_from_stream(stream)
        end

        def self.decode_from_stream(stream)
          message = CodeGeneratorRequest.new({})
          Protobuffness::Decoder.decode_each_field(stream) do |tag, value|
            assign_field_to_message(tag, value, message)
          end
          message
        end

        def self.assign_field_to_message(tag, value, message)
          case tag
          when 1
            message.file_to_generate = value
          when 15
            message.proto_file = Google::Protobuf::FileDescriptorProto.decode(value)
          end
        end
      end
    end
  end
end
