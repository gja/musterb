class Musterb::Evaluator
  include Musterb::ExtractValues

  attr_reader :context

  def initialize(context)
    @context = context
  end  

  def current
    @context.value
  end

  def block_if(value)
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

  def block_unless(value)
    yield if is_falsy? value
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

  def switch_context(value)
    @context = new_context(value)
    yield value
    @context = @context.parent
  end
end