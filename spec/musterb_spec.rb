require 'erubis'

describe Musterb do
  it "correctly replaces variables" do
    planet = "World"
    erb = Musterb.to_erb("Hello, {{planet}}!")
    Erubis::Eruby.new(erb).result(binding).should eq "Hello, World!"
  end
end