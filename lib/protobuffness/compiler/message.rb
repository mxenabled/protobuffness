require 'protobuffness/compiler/attribute_encoder'
require 'protobuffness/compiler/setter'

module Protobuffness
  class Compiler
    class Message
      attr_reader :message_type

      def initialize(message_type)
        @message_type = message_type
      end

      def message_definition
        compile
      end

      private

      def attribute_encoders
        message_type.field.map{|field| AttributeEncoder.new(field).lines}.flatten
      end

      def compile
        define_class do |lines|
          lines.indent(define_initializer)
          lines.indent(define_attribute_methods)
          lines.indent(define_encode_method)
          lines.indent(define_decode_method)
        end
      end

      def define_attribute_methods
        message_type.field.map do |field|
          define_methods_for(field)
        end.flatten
      end

      def define_class
        lines = ["class #{message_type.name}"]
        yield(lines)
        lines << ["end"]
      end

      def define_initializer
        [
          "def initialize(attributes = {})",
          "  @attributes = {}",
          "  attributes.each do |attribute, value|",
          '    send("#{attribute}=", value)',
          "  end",
          "end",
        ]
      end

      def define_methods_for(field)
        lines = [
          "def #{field.name}",
          "  @attributes[:#{field.name}]",
          "end",
        ]
        lines.concat(Setter.define_for(field))
      end

      def define_decode_case_for(field)
        [
          "    when #{field.number}",
          "      message.#{field.name} = value",
        ]
      end

      def define_decode_cases
        message_type.field.map{|field| define_decode_case_for(field)}.flatten
      end

      def define_decode_method
        [
          "def self.decode(bytestring)",
          "  stream = StringIO.new(bytestring)",
          "  message = #{message_type.name}.new",
          "  ::Protobuffness::Decoder.decode_each_field(stream) do |tag, value|",
          "    case tag",
        ]
        .concat(define_decode_cases)
        .concat([
          "    end",
          "  end",
          "  message",
          "end",
        ])
      end

      def define_encode_method
        lines = [
          "def encode(io = nil)",
          "  io ||= ''.force_encoding(Encoding::BINARY)",
        ]
        lines.indent(attribute_encoders)
        lines << "end"
      end
    end
  end
end
