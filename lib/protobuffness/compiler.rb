require "protobuffness/google/protobuf/descriptor_proto"
require "protobuffness/google/protobuf/field_descriptor_proto"
require "protobuffness/google/protobuf/file_descriptor_proto"
require "protobuffness/google/protobuf/compiler/code_generator_request"

module Protobuffness
  module Compiler
    def self.compile(bytestring)
      Google::Protobuf::Compiler::CodeGeneratorRequest.decode(bytestring)
    end

    def self.compile_and_eval(bytestring)
      compile(bytestring)
    end
  end
end
