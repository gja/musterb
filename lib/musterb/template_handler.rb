require 'musterb'
require 'action_view'

class Musterb::TemplateHandler < Musterb::Musterbifier
  def render_partial(partial)
    "<%= render :partial => '#{partial}', :locals => {:initial_context => musterb.context} %>"
  end

  def text_without_escaping(tokens)
    "<%= #{tokens}.html_safe %>"
  end

  def text_with_escaping(tokens)
    "<%= #{tokens} %>"
  end

  def self.compile_mustache(source, options = {})
    initial_context = options[:start_with_existing_context] ? "initial_context" : 'Musterb::InstanceVariableExtractor.new(self, Musterb::BindingExtractor.new(binding))'
    erb = Musterb.to_erb(source, options.merge(:musterbifier_klass => self, :initial_context => initial_context))
    klass = ActionView::Template::Handlers::ERB
    klass.erb_implementation.new(erb, :trim => (klass.erb_trim_mode == "-")).src
  end

  def self.call(template)
    compile_mustache(template.source, :start_with_existing_context => template.locals.include?("initial_context"))
  end
end