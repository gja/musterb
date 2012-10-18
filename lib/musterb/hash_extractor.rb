require 'hashie'

class Musterb::HashExtractor < Musterb::Extractor
  attr_reader :parent, :value

  def initialize(value, parent)
    @value = to_string_access(value)
    @parent = parent
  end

  def [](symbol)
    if @value.has_key? symbol
      @value[symbol]
    else
      @parent[symbol]
    end
  end

  private
  def to_string_access(hash)
    hash.dup.tap do |hash|
      hash.extend Hashie::HashExtensions
      hash.hashie_stringify_keys!
    end
  end
end
