require 'musterb/template_handler'

describe Musterb::TemplateHandler do
  def evaluate(template, binding)
    compiled = "output_buffer = nil; " + Musterb::TemplateHandler::compile_mustache(template)
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
    pending do
      foo = "<br>"
      evaluate("{{foo}}", binding).should eq "&lt;br&gt;"  
    end
  end

  it "does not escape things in triple staches" do
    pending do
      foo = "<br>"
      evaluate("{{{foo}}}", binding).should eq "<br>"
    end    
  end
end