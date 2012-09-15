require "musterb/version"
require "musterb/extract_values"
require "musterb/musterbifier"
require "musterb/binding_extractor"
require "musterb/hash_extractor"
require "musterb/object_extractor"
require "musterb/null_extractor"
require "musterb/evaluator"
require "musterb/chain"

require "erubis"

module Musterb
  def self.to_erb(template, options = {})
    musterbifier = Musterbifier.new(template, options[:render_partial_template])
    initial_context = options[:initial_context] || 'Musterb::BindingExtractor.new binding'
    "<% Musterb::Evaluator.new(#{initial_context}).tap do |musterb| %>#{musterbifier.to_erb}<% end %>"
  end

  def self.render(template, values)
    Erubis::Eruby.new(to_erb template).result(values)
  end
end
