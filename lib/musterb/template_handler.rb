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

  def self.build_initial_context(locals)
    return "initial_context" if locals.include?("initial_context")
    return "Musterb::ExtractValues.new_context(mustache)" if locals.include?("mustache")
    "Musterb::RailsLocalsExtractor.new(#{locals.inspect}, binding, Musterb::InstanceVariableExtractor.new(self, Musterb::NullExtractor.new))"
  end

  def self.call(template)
    initial_context = build_initial_context(template.locals.map(&:to_s))
    erb = Musterb.to_erb(template.source, :musterbifier_klass => self, :initial_context => initial_context)
    klass = ActionView::Template::Handlers::ERB
    klass.erb_implementation.new(erb, :trim => (klass.erb_trim_mode == "-")).src
  end
end
