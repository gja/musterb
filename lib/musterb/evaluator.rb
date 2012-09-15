class Musterb::Evaluator
  def initialize(context)
    @context = context
  end

  def value
    @context.value
  end

  def [](symbol)
    final_context = symbol.split(".").inject(@context) do |con, symbol|      
      new_context con[symbol], con
    end
    final_context.value
  end

  def block(symbol)
    value = self[symbol]
    return if is_falsy? value

    case value
    when Hash
      switch_context(value) { |v| yield v }
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
    when Hash
      false
    when Enumerable
      value.empty?
    else
      !value
    end
  end

  def new_context(value, old_context = @context)
    case value
    when Hash
      Musterb::HashExtractor.new(value, old_context)
    when nil
      Musterb::NullExtractor.new(old_context)
    else
      Musterb::ObjectExtractor.new(value, old_context)
    end
  end

  def old_context
    @context.parent
  end

  def switch_context(value)
    @context = new_context(value)
    yield value
    @context = old_context
  end
end