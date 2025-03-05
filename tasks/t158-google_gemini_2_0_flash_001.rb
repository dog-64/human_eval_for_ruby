def find_max(words)
  return "" if words.empty?

  max_word = ""
  max_unique_chars = 0

  words.each do |word|
    unique_chars = word.chars.uniq.length
    if unique_chars > max_unique_chars
      max_unique_chars = unique_chars
      max_word = word
    elsif unique_chars == max_unique_chars && word < max_word
      max_word = word
    end
  end

  max_word
end