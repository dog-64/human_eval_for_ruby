def all_prefixes(string)
  prefixes = []
  (1..string.length).each do |length|
    prefixes << string[0...length]
  end
  prefixes
end
