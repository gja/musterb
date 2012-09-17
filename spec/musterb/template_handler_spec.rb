require 'musterb/template_handler'

describe Musterb::TemplateHandler do
  def evaluate(template, binding, options = {})
    compiled = "output_buffer = nil; " + Musterb::TemplateHandler::compile_mustache(template, options)
    binding.eval compiled
  end

  it "is wired up correctly" do
    foo = "hi"
    evaluate("{{foo}}", binding).should eq "hi"
  end

  it "renders partials corrects" do
    Musterb::TemplateHandler::compile_mustache("{{>foo}}").should include "render :partial => 'foo', :locals => {:initial_context => musterb.context}"
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
    evaluate("{{to_s}}", binding, :start_with_existing_context => true).should eq "2"
  end
end