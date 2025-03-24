def all_prefixes(string)
  prefixes = []
  string.length.downto(0) do |i|
    prefixes << string[0...i]
  end
  prefixes.sort_by(&:length)
end