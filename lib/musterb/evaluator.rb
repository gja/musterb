class Musterb::Evaluator
  def initialize(_binding)
    @context = Musterb::BindingExtractor.new _binding
  end

  def [](symbol)
    @context[symbol]
  end

  def is_falsy?(value)
    !value
  end

  def block(symbol)
    value = self[symbol]
    return if is_falsy? value
    yield
  end

  def block_unless(symbol)
    yield if is_falsy? self[symbol]
  end
end