require 'musterb'

module Musterb::TemplateHandler
  def self.render_partial_template(partial)
    "render :partial => '#{partial}', :locals => {:initial_context => musterb.context}"
  end

  def self.call(template)
   options = {:render_partial_template => method(:render_partial_template)}
   options[:initial_context] = "initial_context" if template.locals.include? "initial_context"
   erb = Musterb.to_erb(template.source, options)
   klass = ActionView::Template::Handlers::ERB
   klass.erb_implementation.new(erb, :trim => (klass.erb_trim_mode == "-")).src
  end
end