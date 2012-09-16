require 'musterb'
require 'action_view'

module Musterb::TemplateHandler
  def self.render_partial_template(partial)
    "render :partial => '#{partial}', :locals => {:initial_context => musterb.context}"
  end

  def self.compile_mustache(source, options = {})
    options = options.merge(:render_partial_template => method(:render_partial_template))
    erb = Musterb.to_erb(source, options)
    klass = ActionView::Template::Handlers::ERB
    klass.erb_implementation.new(erb, :trim => (klass.erb_trim_mode == "-")).src 
  end

  def self.call(template)
   options = {}
   options[:initial_context] = "initial_context" if template.locals.include? "initial_context"
   compile_mustache(template.source, options)   
  end
end