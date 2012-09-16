class Musterb::Chain
  include Musterb::ExtractValues

  def initialize(value)
    @context = new_context(value, Musterb::NullExtractor.new(nil))
  end
end