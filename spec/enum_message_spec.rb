RSpec.describe "enum message encoding" do
  # enum Crunchiness {
  #   FATTY  = 0;
  #   CRISPY = 1;
  #   CEMENT = 2;
  # }
  # message Bacon {
  #   required uint32 id = 1;
  #   optional Crunchiness chrunchiness = 2;
  # }
  class Crunchiness
    VALUES = {
      :FATTY  => 0,
      :CRISPY => 1,
      :CEMENT => 2,
    }.freeze

    attr_reader :label

    def initialize(label)
      @label = label
    end

    def tag
      VALUES[label]
    end
  end

  class Bacon
    def initialize(attributes)
      @attributes = {}
      attributes.each do |attribute, value|
        public_send("#{attribute}=", value)
      end
    end

    ## Attributes

    def id
      @attributes[:id]
    end

    def id=(id)
      raise ArgumentError, "id is not a number" unless id.respond_to?(:to_i)
      raise ArgumentError, "id is too large" unless id.to_i <= 4_294_967_295
      raise ArgumentError, "id cannot be negative" unless id.to_i >= 0
      @attributes[:id] = id
    end

    def crunchiness
      @attributes[:crunchiness]
    end

    def crunchiness=(crunchiness)
      @attributes[:crunchiness] = Crunchiness.new(crunchiness)
    end

    ## Encoding

    def encode
      stream = StringIO.new
      stream.set_encoding(Encoding::BINARY)
      encode_to_stream(stream)
      stream.string
    end

    def encode_to_stream(stream)
      stream << Protobuffness::Uint32.encode_attribute(@attributes[:id], 1)
      unless @attributes[:crunchiness].nil?
        stream << Protobuffness::Enum.encode_attribute(@attributes[:crunchiness], 2)
      end
    end
  end

  it "encodes a fatty bacon" do
    bacon = Bacon.new(:id => 123, :crunchiness => :FATTY)
    expect(bacon.encode).to eq binary_string("\b{\x10\x00")
  end

  it "encodes a crunchy bacon" do
    bacon = Bacon.new(:id => 456, :crunchiness => :CRISPY)
    expect(bacon.encode).to eq binary_string("\b\xC8\x03\x10\x01")
  end

  it "encodes a cement bacon" do
    bacon = Bacon.new(:id => 25_432, :crunchiness => :CEMENT)
    expect(bacon.encode).to eq binary_string("\b\xD8\xC6\x01\x10\x02")
  end
end
