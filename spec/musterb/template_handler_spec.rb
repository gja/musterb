require 'musterb/template_handler'
require 'ostruct'

describe Musterb::TemplateHandler do
  def compile_template(template, options = {})
    template = OpenStruct.new({:source => template, :locals => []}.merge(options))
    "output_buffer = nil; " + Musterb::TemplateHandler::call(template)
  end

  def evaluate(template, binding, options = {})    
    binding.eval compile_template(template, options)
  end

  it "is wired up correctly" do
    foo = "hi"
    evaluate("{{foo}}", binding).should eq "hi"
  end

  it "renders partials corrects" do
    compile_template("{{>foo}}").should include "render :partial => 'foo', :locals => {:initial_context => musterb.context}"
  end

  it "escapes things by default" do
    foo = "<br>"
    evaluate("{{foo}}", binding).should eq "&lt;br&gt;"  
  end

  it "does not escape things in triple staches" do    
    foo = "<br>"
    evaluate("{{{foo}}}", binding).should eq "<br>"
  end

  it "can read from instance variables (likely on the controller)" do
    @foo = "hello"
    evaluate("{{foo}}", binding).should eq "hello"
  end

  it "can be bootstrapped from an initial_context" do
    initial_context = Musterb::ObjectExtractor.new(2, nil)
    evaluate("{{to_s}}", binding, :locals => ["initial_context"]).should eq "2"
  end

  it "favors locals over instance variables if passed into locals" do
    @foo = "hello"
    foo = "bye"
    evaluate("{{foo}}", binding, :locals => ["foo"]).should eq "bye"
  end
end