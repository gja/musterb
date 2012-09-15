require 'erubis'

describe Musterb do
  it "correctly replaces variables" do
    planet = "World"
    erb = Musterb.to_erb("Hello, {{planet}}!")
    Erubis::Eruby.new(erb).result(binding).should eq "Hello, World!"
  end

  it "correctly evaluates if a variable is set" do
    hash = {:set_var => "set"}
    Musterb.render("{{#set_var}}foo{{/set_var}}", hash).should eq "foo"
    Musterb.render("{{#unset_var}}foo{{/unset_var}}", hash).should eq ""
  end

  it "skips blocks for truthy values" do
    hash = {:set_var => "set"}
    Musterb.render("{{^set_var}}foo{{/set_var}}", hash).should eq ""
    Musterb.render("{{^unset_var}}foo{{/unset_var}}", hash).should eq "foo"
  end

  it "can pull out deeply nested values" do
    hash = {:foo => {:bar => {:baz => 42}}}
    Musterb.render("{{foo.bar.baz}}", hash).should eq "42"
  end

  it "can iterate over values" do
    hash = {:foos => [1, 2, 3]}
    Musterb.render("{{#foos}}{{.}}{{/foos}}", hash).should eq "123"
  end
end