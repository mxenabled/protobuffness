RSpec.describe "encoding a very simple message" do
  let(:schema) {
    ::Protobuffness::Schema.new([
      ::Protobuffness::Field::String.new(:required, 1),
    ])
  }
  let(:values) { {:description => "crispy"} }
  subject { ::Protobuffness.encode(values, schema) }

  specify { expect(subject.encode).to eq binary_string("\n\x06crispy") }
end
