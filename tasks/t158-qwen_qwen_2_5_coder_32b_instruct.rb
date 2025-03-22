def find_max(words)
  return "" if words.empty?

  words.sort.find do |word|
    word.chars.uniq.size == words.map { |w| w.chars.uniq.size }.max
  end
end