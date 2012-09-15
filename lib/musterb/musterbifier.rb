class Musterb::Musterbifier
  def initialize(template, render_partial_template = nil)
    @template = template
    @render_partial_template = render_partial_template || method(:partials_not_implemented)
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
        "<%= #{@render_partial_template.call(match[1..-1].strip)} %>"
      else
        "<%== #{fetch match} %>"
      end
    end
  end

  def partials_not_implemented(partial)
    "raise NotImplementedError, 'Don't know how to render partial: #{partial}'"
  end
end