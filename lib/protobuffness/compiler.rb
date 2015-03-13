# TODO: remove these protobuf dependencies once we can self-host the compilation process
require 'protobuf'
require 'protobuf/descriptors'
require 'protobuf/code_generator'

module Protobuffness
  class Compiler
    attr_reader :request

    def initialize(request_bytes)
      @request = ::Google::Protobuf::Compiler::CodeGeneratorRequest.decode(request_bytes)
    end

    def response
      @response ||= ::Google::Protobuf::Compiler::CodeGeneratorResponse.new(:file => files_to_generate)
    end

    def response_binary
      response.encode
    end

    private

    def files_to_generate
      request.proto_file.map do |file_descriptor|
        ::Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
          :name => file_name(file_descriptor),
          :content => generate_ruby(file_descriptor),
        )
      end
    end

    def file_name(file_descriptor)
      file_descriptor.name.sub(".proto", ".pb.rb")
    end

    def generate_ruby(file_descriptor)
      "class Sally; end"
    end
  end
end
