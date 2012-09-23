class Musterb::BindingExtractor
  attr_reader :value, :parent

  def initialize(_binding, parent)
    @binding = _binding
    @parent = parent
  end

  def [](symbol)
    @binding.eval symbol
  rescue NameError
    parent[symbol]
  end
end
