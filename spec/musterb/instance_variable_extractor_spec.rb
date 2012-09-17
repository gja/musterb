describe Musterb::InstanceVariableExtractor do
  class TestClass
    def initialize
      @foo = "bar"
    end
  end

  it "reads instance variables" do
    Musterb::InstanceVariableExtractor.new(TestClass.new, nil)["foo"].should eq "bar"    
  end

  it "delegates to the parent if it's not found" do
    Musterb::InstanceVariableExtractor.new(TestClass.new, Musterb::ObjectExtractor.new(2, nil))["to_s"].should eq "2"
  end
end