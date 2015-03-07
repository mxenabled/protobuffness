if ENV['REPORT_COVERAGE']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'protobuffness'

def binary_string(string)
  string.force_encoding(Encoding::BINARY)
end
