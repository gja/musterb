class Musterb::NullExtractor
  attr_reader :value, :parent

  def initialize(parent = nil)
    @parent = parent || self
  end

  def [](value)
    nil
  end
end