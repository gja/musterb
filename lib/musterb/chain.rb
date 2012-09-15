class Musterb::Chain
  include ExtractValues

  def initialize(value)
    @context = new_context(value, Musterb::NullExtractor.new(nil))
  end
end