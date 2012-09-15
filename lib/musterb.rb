require "musterb/version"
require "musterb/extract_values"
require "musterb/musterbifier"
require "musterb/binding_extractor"
require "musterb/hash_extractor"
require "musterb/object_extractor"
require "musterb/null_extractor"
require "musterb/evaluator"
require "musterb/chain"

module Musterb
  def self.to_erb(template)
    musterbifier = Musterbifier.new(template)
    "<% Musterb::Evaluator.new(Musterb::BindingExtractor.new binding).tap do |musterb| %>#{musterbifier.to_erb}<% end %>"
  end
end
