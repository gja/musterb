class ObjectExtractor
  attr_reader :parent

  def initialize(value, parent)
    @value = value
    @parent = parent
  end

  def [](symbol)
    if @value.respond_to? symbol
      @value.send(symbol)
    else
      @parent[symbol]
    end
  end
end