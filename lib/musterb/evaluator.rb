class Musterb::Evaluator
  def initialize(_binding)
    @context = Musterb::BindingExtractor.new _binding
  end

  def [](symbol)
    @context[symbol]
  end

  def block(symbol)
    value = self[symbol]
    return if is_falsy? value

    case value
    when Enumerable
      value.each { |e| switch_context(e) { |v| yield v } }
    else
      switch_context(value) { |v| yield v }
    end
  end

  def block_unless(symbol)
    yield if is_falsy? self[symbol]
  end

  private

  def is_falsy?(value)
    case value
    when Enumerable
      value.empty?
    else
      !value
    end
  end

  def switch_context(value)
    yield value
  end
end