class Musterb::Musterbifier
  def initialize(template)
    @template = template
  end

  def fetch(match)
    match = match.strip
    return "musterb.current" if match == '.'
    tokens = match.split(".")
    last_token = tokens.pop
    fetch_command = tokens.inject("musterb") do |str, token|
      "#{str}.chain('#{token}')"
    end
    "#{fetch_command}['#{last_token}']"
  end

  def block_if(tokens)
    "<% musterb.block_if #{tokens} do %>"
  end

  def block_unless(tokens)
    "<% musterb.block_unless #{tokens} do %>"
  end

  def block_end
    "<% end %>"
  end

  def text_without_escaping(tokens)
    "<%= #{tokens} %>"
  end

  def text_with_escaping(tokens)
    "<%== #{tokens} %>"
  end

  def comment
    ""
  end

  def change_token
    raise NotImplementedError, 'Not able to change the mustache delimiter just yet'
  end

  def render_partial(partial)
    raise NotImplementedError, "Override render_partial in Musterbifier to render partials"    
  end

  def to_erb
    @template.gsub(/\{\{(\{?[^\}]*\}?)\}\}/) do |match|
      match = $1
      case match[0]
      when '#'
        block_if fetch match[1..-1]
      when '^'
        block_unless fetch match[1..-1]        
      when "/"
        block_end
      when '{'
        text_without_escaping fetch match[1..-2]        
      when '&'
        text_without_escaping fetch match[1..-1]
      when '!'
        comment
      when '='
        change_token
      when '>'
        render_partial match[1..-1].strip        
      else
        text_with_escaping fetch match        
      end
    end
  end
end