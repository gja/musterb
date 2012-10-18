class Musterb::InstanceVariableExtractor
  attr_reader :parent, :value

  def initialize(value, parent)
    @value = value
    @parent = parent
  end

  def [](symbol)
    if value.instance_variable_defined?("@#{symbol}")
      value.instance_variable_get("@#{symbol}")
    else
      @parent[symbol]
    end
  end
end