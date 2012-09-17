require "erubis"

module Musterb
  autoload :VERSION,                   "musterb/version"

  autoload :ExtractValues,             "musterb/extract_values"
  autoload :Musterbifier,              "musterb/musterbifier"
  autoload :BindingExtractor,          "musterb/binding_extractor"
  autoload :HashExtractor,             "musterb/hash_extractor"
  autoload :ObjectExtractor,           "musterb/object_extractor"
  autoload :InstanceVariableExtractor, "musterb/instance_variable_extractor"
  autoload :NullExtractor,             "musterb/null_extractor"
  autoload :Evaluator,                 "musterb/evaluator"
  autoload :Chain,                     "musterb/chain"

  autoload :TemplateHandler,           "musterb/template_handler"

  def self.to_erb(template, options = {})
    klass = options[:musterbifier_klass] || Musterbifier
    musterbifier = klass.new(template)
    initial_context = options[:initial_context] || 'Musterb::BindingExtractor.new binding'
    "<% Musterb::Evaluator.new(#{initial_context}).tap do |musterb| %>#{musterbifier.to_erb}<% end %>"
  end

  def self.render(template, values)
    Erubis::Eruby.new(to_erb template).result(values)
  end
end
