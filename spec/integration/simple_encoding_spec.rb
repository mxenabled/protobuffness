RSpec.describe "encoding very simple messages" do
  context "single required string" do
    let(:schema) {
      ::Protobuffness::Schema.new([
        ::Protobuffness::Field::String.new(:required, :description, 1),
      ])
    }

    def encode(description)
      ::Protobuffness.encode({:description => description}, schema)
    end

    specify { expect(encode("bob")).to eq binary_string("\n\x03bob") }
    specify { expect(encode("crispy")).to eq binary_string("\n\x06crispy") }
  end
end
