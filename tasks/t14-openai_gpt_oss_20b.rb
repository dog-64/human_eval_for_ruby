def all_prefixes(string)
  prefixes = []
  (1..string.length).each do |i|
    prefixes << string[0, i]
  end
  prefixes
end