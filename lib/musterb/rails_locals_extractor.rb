class Musterb::RailsLocalsExtractor
  attr_reader :parent, :value

  def initialize(locals, binding, parent)
    @locals = locals
    @parent = parent
    @binding = binding
  end

  def [](symbol)
    if @locals.include? symbol
      @binding.eval symbol
    else
      parent[symbol]
    end
  end
end