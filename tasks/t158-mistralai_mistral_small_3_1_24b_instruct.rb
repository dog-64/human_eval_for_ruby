def find_max(words)
  return "" if words.empty?

  max_word = ""
  max_unique_count = 0

  words.each do |word|
    unique_chars = word.chars.uniq
    unique_count = unique_chars.size

    if unique_count > max_unique_count || (unique_count == max_unique_count && word < max_word)
      max_word = word
      max_unique_count = unique_count
    end
  end

  max_word
end