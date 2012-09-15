describe Musterb::ObjectExtractor do
  it "calls methods on the object" do
    extractor = Musterb::ObjectExtractor.new(2, nil)
    extractor["to_s"].should eq "2"
  end

  it "delegates to the parent if there it doesn't respnd to something" do
    extractor = Musterb::ObjectExtractor.new(2, Musterb::ObjectExtractor.new("string", nil))
    extractor["upcase"].should eq "STRING"
  end

  it "pulls out values as ." do
    extractor = Musterb::ObjectExtractor.new(2, nil)
    extractor["."].should eq 2
  end
end