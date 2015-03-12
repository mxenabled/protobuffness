require "protobuffness/compiler"

RSpec.describe "compiling protobuf messages" do
  # represents the byte string that we will receive from `protoc` when trying to compile a message like:
  # message Sally {
  #   required string mood = 1;
  #   optional uint32 age  = 2;
  # }
  let(:request_bytes){ binary_string("\n\vsally.protoz\xDE\x01\n\vsally.proto\"\"\n\x05Sally\x12\f\n\x04mood\x18\x01 \x02(\t\x12\v\n\x03age\x18\x02 \x01(\rJ\xAA\x01\n\x06\x12\x04\x00\x00\x03\x01\n\n\n\x02\x04\x00\x12\x04\x00\x00\x03\x01\n\n\n\x03\x04\x00\x01\x12\x03\x00\b\r\n\v\n\x04\x04\x00\x02\x00\x12\x03\x01\x02\e\n\f\n\x05\x04\x00\x02\x00\x04\x12\x03\x01\x02\n\n\f\n\x05\x04\x00\x02\x00\x05\x12\x03\x01\v\x11\n\f\n\x05\x04\x00\x02\x00\x01\x12\x03\x01\x12\x16\n\f\n\x05\x04\x00\x02\x00\x03\x12\x03\x01\x19\x1A\n\v\n\x04\x04\x00\x02\x01\x12\x03\x02\x02\e\n\f\n\x05\x04\x00\x02\x01\x04\x12\x03\x02\x02\n\n\f\n\x05\x04\x00\x02\x01\x05\x12\x03\x02\v\x11\n\f\n\x05\x04\x00\x02\x01\x01\x12\x03\x02\x12\x15\n\f\n\x05\x04\x00\x02\x01\x03\x12\x03\x02\x19\x1A") }
  let(:request_stream) { StringIO.new(request_bytes) }

  after do
    Object.send(:remove_const, :Sally) if defined?(Sally)
  end

  it "decodes the message into tags and values" do
    response = ::Protobuffness::Compiler.compile_and_eval(request_bytes)
    expect(defined?(Sally)).to eq true
    sally = Sally.new(:mood => "frustrated", :age => 2)
    expect(sally.age).to eq 2
    expect(sally.mood).to eq "frustrated"
  end
end
