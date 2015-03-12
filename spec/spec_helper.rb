if ENV['REPORT_COVERAGE']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "protobuffness"
require "pry"

def binary_string(str)
  str.force_encoding(Encoding::BINARY)
end
