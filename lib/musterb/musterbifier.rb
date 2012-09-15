class Musterb::Musterbifier
  def initialize(template)
    @template = template
  end

  def to_erb
    @template.gsub(/\{\{(\{?[^\}]*\}?)\}\}/) do |match|
      match = $1
      case match[0]
      when '#'
        "<% musterb.block '#{match[1..-1].strip}' do %>"
      when '^'
        "<% musterb.block_unless '#{match[1..-1].strip}' do %>"
      when "/"
        "<% end %>"
      when '{'
        "<%= musterb['#{match[1..-2].strip}'] %>"
      when '&'
        "<%= musterb['#{match[1..-1].strip}'] %>"
      when '!'
        ""
      else
        "<%== musterb['#{match.strip}'] %>"
      end
    end
  end
end