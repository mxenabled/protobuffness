require "protobuffness/compiler"

RSpec.describe Protobuffness::Compiler do
  let(:request_bytes) { File.read("spec/fixtures/sally_request.bin", :mode => "rb") }

  subject { described_class.new(request_bytes) }

  it "generates a code generator response" do
    expect(subject.response).to be_a(::Google::Protobuf::Compiler::CodeGeneratorResponse)
  end

  it "produces a binary response" do
    binary = subject.response_binary
    expect(binary).to be_a(String)
    expect(binary.encoding).to eq Encoding::BINARY
  end
end
