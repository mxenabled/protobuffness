if ENV["REPORT_COVERAGE"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'protobuffness'
require "pry"

def binary_string(str)
  str.force_encoding(Encoding::BINARY)
end

def compile(message_file_name)
  proto_path = File.expand_path("../fixtures/proto/#{message_file_name}", __FILE__)
  ruby_path = proto_path.sub(".proto", ".pb.rb")
  proto_load_path = File.dirname(proto_path)
  File.unlink(ruby_path) if File.exist?(ruby_path)
  `protoc --plugin=./exe/protoc-gen-protobuffness --protobuffness_out=#{proto_load_path} -I #{proto_load_path} #{proto_path}`
  ruby_path
end

def binary_string(a_string)
  a_string.force_encoding(Encoding::BINARY)
end
