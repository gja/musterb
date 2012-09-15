class Musterb::Musterbifier
  def initialize(template)
    @template = template
  end

  def fetch(tokens)
    tokens = tokens.strip.split(".")
    last_token = tokens.pop
    fetch_command = tokens.inject("musterb") do |str, token|
      "#{str}.chain('#{token}')"
    end
    "#{fetch_command}['#{last_token}']"
  end

  def to_erb
    @template.gsub(/\{\{(\{?[^\}]*\}?)\}\}/) do |match|
      match = $1
      case match[0]
      when '#'
        "<% musterb.block_if #{fetch match[1..-1]} do %>"
      when '^'
        "<% musterb.block_unless #{fetch match[1..-1]} do %>"
      when "/"
        "<% end %>"
      when '{'
        "<%= #{fetch match[1..-2]} %>"
      when '&'
        "<%= #{fetch match[1..-1]} %>"
      when '!'
        ""
      when '.'
        "<%== musterb.current %>"
      when '='
        raise NotImplementedError, 'Not able to change the mustache delimiter just yet'
      when '>'
        raise NotImplementedError, 'Not implemented support for partials'
      else
        "<%== #{fetch match} %>"
      end
    end
  end
end