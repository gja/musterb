class Musterb::Evaluator
  def initialize(_binding)
    @context = Musterb::BindingExtractor.new _binding
  end

  def [](symbol)
    @context[symbol]
  end
end