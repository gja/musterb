require "musterb/version"
require "musterb/musterbifier"
require "musterb/binding_extractor"
require "musterb/evaluator"

module Musterb
  def self.to_erb(template)
    musterbifier = Musterbifier.new(template)
    "<% Musterb::Evaluator.new(binding).tap do |musterb| %>#{musterbifier.to_erb}<% end %>"
  end
end
