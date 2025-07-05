def find_max(words)
  return "" if words.empty?

  words.max_by do |word|
    [word.chars.uniq.length, -word.length]
  end
end