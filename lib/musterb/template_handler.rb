require 'musterb'

module Musterb::TemplateHandler
  def self.call(template)
   erb = Musterb.to_erb(template.source)
   klass = ActionView::Template::Handlers::ERB
   klass.erb_implementation.new(erb, :trim => (klass.erb_trim_mode == "-")).src
  end
end