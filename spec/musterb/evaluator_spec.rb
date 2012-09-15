describe Musterb::Evaluator do
  it "can pull local variables out from the binding" do
    foo = "bar"
    evaluator = Musterb::Evaluator.new binding
    evaluator["foo"].should eq "bar"
  end
end