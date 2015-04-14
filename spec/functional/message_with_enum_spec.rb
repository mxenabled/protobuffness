RSpec.describe "enum message encoding" do
  before :context do
    require compile("bacon.proto")
  end

  after :context do
    Object.send(:remove_const, :Bacon) if defined?(Bacon)
    Object.send(:remove_const, :Crunchiness) if defined?(Crunchiness)
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

  it "can specify the tag for an enum" do
    bacon = Bacon.new(:id => 456, :crunchiness => 1)
    expect(bacon.encode).to eq binary_string("\b\xC8\x03\x10\x01")
  end

  it "can specify an enum object" do
    bacon = Bacon.new(:id => 456, :crunchiness => Crunchiness.new(:CRISPY))
    expect(bacon.encode).to eq binary_string("\b\xC8\x03\x10\x01")
  end

  it "rejects fake values" do
    expect{ Bacon.new(:crunchiness => :WAT) }.to raise_error(ArgumentError)
  end
end
