module Musterb::ExtractValues
  def value
    @context.value
  end

  def [](symbol)
    @context[symbol]
  end

  def chain(symbol)
    Musterb::Chain.new self[symbol]
  end

  def self.new_context(value, old_context = @context)
    case value
    when Musterb::Extractor
      value
    when Hash
      Musterb::HashExtractor.new(value, old_context)
    when nil
      Musterb::NullExtractor.new(old_context)
    else
      Musterb::ObjectExtractor.new(value, old_context)
    end
  end

  private
  def new_context(value, old_context = @context)
    Musterb::ExtractValues.new_context(value, old_context)
  end
end
