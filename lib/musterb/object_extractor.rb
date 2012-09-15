class ObjectExtractor
  attr_reader :parent

  def initialize(value, parent)
    @value = value
    @parent = parent
  end
end