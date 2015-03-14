# TODO: remove these protobuf dependencies once we can self-host the compilation process
require 'protobuf'
require 'protobuf/descriptors'
require 'protobuf/code_generator'

require "protobuffness/compiler/file"

# I don't mind monkeypatching here since this code will only be loading when compiling
# protobuf messages. It will never be loaded during the normal runtime of an application.
class Array
  def indent(other_array)
    self << other_array.map{|line| "  #{line}"}
  end
end

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
        File.new(file_descriptor).file
      end
    end
  end
end
