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
end
