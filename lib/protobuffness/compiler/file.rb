require "protobuffness/compiler/message"

module Protobuffness
  class Compiler
    class File
      attr_reader :file_descriptor

      def initialize(file_descriptor)
        @file_descriptor = file_descriptor
      end

      def file
        ::Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
          :name => file_name,
          :content => generate_ruby,
        )
      end

      private

      def file_name
        file_descriptor.name.sub(".proto", ".pb.rb")
      end

      def generate_ruby
        messages.map(&:message_definition).flatten.join("\n")
      end

      def messages
        file_descriptor.message_type.map do |message_type|
          Message.new(message_type)
        end
      end
    end
  end
end
