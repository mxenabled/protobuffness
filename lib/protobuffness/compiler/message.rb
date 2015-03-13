module Protobuffness
  class Compiler
    class Message
      attr_reader :message_type

      def initialize(message_type)
        @message_type = message_type
        compile
      end

      def message_definition
        stream.string
      end

      private

      def compile
        stream.puts "class #{message_type.name}"
        define_initializer
        define_attribute_methods
        stream.puts "end"
      end

      def define_attribute_methods
        message_type.field.each do |field|
          define_methods_for(field)
        end
      end

      def define_initializer
        stream.puts "  def initialize"
        stream.puts "    @attributes = {}"
        stream.puts "  end"
      end

      def define_methods_for(field)
        stream.puts "  def #{field.name}"
        stream.puts "    @attributes[:#{field.name}]"
        stream.puts "  end"
        stream.puts ""
        stream.puts "  def #{field.name}=(#{field.name})"
        stream.puts "    @attributes[:#{field.name}] = #{field.name}"
        stream.puts "  end\n"
      end

      def stream
        @stream ||= StringIO.new
      end
    end
  end
end
