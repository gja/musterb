describe Musterb::BindingExtractor do
  it "can pull out local variables from the binding" do
    foo = "bar"
    extractor = Musterb::BindingExtractor.new binding
    extractor["foo"].should eq "bar"
  end

  it "returns nil if the local variable cannot be found" do
    extractor = Musterb::BindingExtractor.new binding
    extractor["foo"].should be_nil
  end
end