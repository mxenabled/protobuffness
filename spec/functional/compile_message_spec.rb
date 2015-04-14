RSpec.describe "compiling a simple message" do
  before :context do
    require compile("sally.proto")
  end

  after :context do
    Object.send(:remove_const, :Sally) if defined?(Sally)
  end

  it "defines a Sally class" do
    expect(defined?(Sally)).to eq "constant"
  end

  it "generates getters and setters" do
    sally = Sally.new
    sally.mood = "grumpy"
    sally.age = 9
    expect(sally.mood).to eq "grumpy"
    expect(sally.age).to eq 9
  end

  it "generates an initializer which accepts a hash of values" do
    sally = Sally.new(:mood => "been better", :age => 20)
    expect(sally.age).to eq 20
    expect(sally.mood).to eq "been better"
  end

  it "generates an encode method" do
    sally = Sally.new
    sally.mood = "slightly better"
    sally.age = 28
    expect(sally.encode).to eq(binary_string("\n\x0Fslightly better\x10\x1C"))
  end
end
