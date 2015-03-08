RSpec.describe "message encoding" do
  # message Sally {
  #   required string mood = 1;
  #   optional uint32 age  = 2;
  # }
  class Sally
    def initialize(attributes)
      @attributes = attributes
    end

    def encode
      stream = StringIO.new
      encode_to_stream(stream)
      stream.string
    end

    def encode_to_stream(stream)
      stream << Protobuffness::String.encode_attribute(@attributes[:mood], 1)
      unless @attributes[:age].nil?
        stream << Protobuffness::Uint32.encode_attribute(@attributes[:age], 2)
      end
    end
  end

  it "enodes an ageless Sally message" do
    ageless = Sally.new(:mood => "happy")
    expect(ageless.encode).to eq binary_string("\n\x05happy")
  end

  it "encodes a tween Sally message" do
    tween = Sally.new(:mood => "poor", :age => 15)
    expect(tween.encode).to eq binary_string("\n\x04poor\x10\x0F")
  end

  it "encodes an adult Sally message" do
    adult = Sally.new(:mood => "slightly better", :age => 28)
    expect(adult.encode).to eq binary_string("\n\x0Fslightly better\x10\x1C")
  end
end
