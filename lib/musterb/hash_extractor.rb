class HashExtractor
  attr_reader :parent

  def initialize(value, parent)
    @value = value
    @parent = parent
  end

  def [](symbol)
    if @value.has_key? symbol
      @value[symbol]
    else
      @parent[symbol]
    end
  end
end