describe HashExtractor do
  it "can pull values out from a hash" do
    extractor = HashExtractor.new({"foo" => "bar"}, nil)
    extractor["foo"].should eq "bar"
  end

  it "can pull values out from a symbol" do
    extractor = HashExtractor.new({:foo => "bar"}, nil)
    extractor["foo"].should eq "bar"
  end

  it "delegates to the parent if there is no match" do
    extractor = HashExtractor.new({}, HashExtractor.new({:foo => "bar"}, nil))
    extractor["foo"].should eq "bar"
  end
end