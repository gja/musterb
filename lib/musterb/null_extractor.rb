class Musterb::NullExtractor
  attr_reader :value, :parent

  def initialize(parent)
    @parent = parent
  end

  def [](value)
    nil
  end
end