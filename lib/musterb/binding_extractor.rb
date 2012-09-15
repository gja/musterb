class Musterb::BindingExtractor
  def initialize(_binding)
    @binding = _binding
  end

  def [](symbol)
    @binding.eval <<-EOF
    begin
      #{symbol}
    rescue NameError
      nil
    end
EOF
  end
end