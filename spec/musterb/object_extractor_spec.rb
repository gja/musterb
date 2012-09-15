describe ObjectExtractor do
  it "calls methods on the object" do
    extractor = ObjectExtractor.new(2, nil)
    extractor["to_s"].should eq "2"
  end

  it "delegates to the parent if there it doesn't respnd to something" do
    extractor = ObjectExtractor.new(2, ObjectExtractor.new("string", nil))
    extractor["upcase"].should eq "STRING"
  end
end