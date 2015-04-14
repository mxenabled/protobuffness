RSpec.describe "message encoding" do
  # message Sally {
  #   required string mood = 1;
  #   optional uint32 age  = 2;
  # }
  class Sally
    def initialize(attributes)
      @attributes = {}
      attributes.each do |attribute, value|
        public_send("#{attribute}=", value)
      end
    end

    ## Attributes

    def age
      @attributes[:age]
    end

    def age=(age)
      raise ArgumentError, "age is not a number" unless age.respond_to?(:to_i)
      raise ArgumentError, "age is too large" unless age.to_i <= 4_294_967_295
      raise ArgumentError, "age cannot be negative" unless age.to_i >= 0
      @attributes[:age] = age
    end

    def mood
      @attributes[:mood]
    end

    def mood=(mood)
      raise ArgumentError, "mood is not stringy" unless mood.respond_to?(:to_str)
      @attributes[:mood] = mood
    end

    ## Encoding

    def encode
      stream = StringIO.new
      stream.set_encoding(Encoding::BINARY)
      encode_to_stream(stream)
      stream.string
    end

    def encode_to_stream(stream)
      stream << Protobuffness::String.encode_attribute(@attributes[:mood], 1)
      unless @attributes[:age].nil?
        stream << Protobuffness::Uint32.encode_attribute(@attributes[:age], 2)
      end
    end

    ## Decoding

    def self.decode(bytestring)
      stream = StringIO.new(bytestring)
      decode_from_stream(stream)
    end

    def self.decode_from_stream(stream)
      sally = Sally.new({})
      Protobuffness::Decoder.decode_each_field(stream) do |tag, value|
        assign_field_to_message(tag, value, sally)
      end
      sally
    end

    def self.assign_field_to_message(tag, value, sally)
      case tag
      when 1
        sally.mood = value
      when 2
        sally.age = value
      else
        # assign to unknown attributes
      end
    end
  end

  it "encodes an ageless Sally message" do
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

  it "decodes an ageless Sally message" do
    ageless = Sally.decode(binary_string("\n\x05happy"))
    expect(ageless.age).to be_nil
    expect(ageless.mood).to eq "happy"
  end

  it "decodes a tween Sally message" do
    tween = Sally.decode(binary_string("\n\x04poor\x10\x0F"))
    expect(tween.age).to eq 15
    expect(tween.mood).to eq "poor"
  end

  it "decodes an adult Sally message" do
    adult = Sally.decode(binary_string("\n\x0Fslightly better\x10\x1C"))
    expect(adult.age).to eq 28
    expect(adult.mood).to eq "slightly better"
  end
end
