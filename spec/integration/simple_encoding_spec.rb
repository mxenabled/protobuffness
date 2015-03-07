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

  context "single required uint" do
    let(:schema) {
      ::Protobuffness::Schema.new([
        ::Protobuffness::Field::Uint32.new(:required, :amount, 1),
      ])
    }

    def encode(amount)
      ::Protobuffness.encode({:amount => amount}, schema)
    end

    specify { expect(encode(45)).to eq binary_string("\b-") }
    specify { expect(encode(127)).to eq binary_string("\b\x7F") }
    specify { expect(encode(128)).to eq binary_string("\b\x80\x01") }
    specify { expect(encode(68_431)).to eq binary_string("\b\xCF\x96\x04") }
  end
end
