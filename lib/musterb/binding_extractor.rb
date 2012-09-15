class Musterb::BindingExtractor
  def initialize(_binding)
    @binding = _binding
  end

  def [](symbol)
    @binding.eval symbol
  rescue NameError
    nil
  end
end
