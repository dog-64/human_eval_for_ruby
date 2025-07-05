def all_prefixes(string)
  prefixes = []
  (0..string.length).each do |i|
    prefixes << string[0...i]
  end
  prefixes.sort_by { |prefix| prefix.length }
end
