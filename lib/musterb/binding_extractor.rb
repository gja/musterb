class Musterb::BindingExtractor
  def initialize(_binding)
    @binding = _binding
  end

  def [](symbol)
    eval symbol, @binding
  end
end