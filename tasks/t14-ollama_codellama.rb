def all_prefixes(string)
  prefixes = []
  string.each_char do |c|
    prefixes << c
  end
  prefixes.sort!
end
