require 'erubis'

describe Musterb do
  def evaluate(template, _binding)
    erb = Musterb.to_erb(template)
    Erubis::Eruby.new(erb).result(_binding)
  end

  it "correctly replaces variables" do
    planet = "World"
    evaluate("Hello, {{planet}}!", binding).should eq "Hello, World!"
  end

  it "correctly evaluates if a variable is set" do
    set_var = "set"
    unset_var = nil
    evaluate("{{#set_var}}foo{{/set_var}}", binding).should eq "foo"
    evaluate("{{#unset_var}}foo{{/unset_var}}", binding).should eq ""
  end

  it "skips blocks for truthy values" do
    set_var = "set"
    unset_var = nil
    evaluate("{{^set_var}}foo{{/set_var}}", binding).should eq ""
    evaluate("{{^unset_var}}foo{{/unset_var}}", binding).should eq "foo"
  end
end