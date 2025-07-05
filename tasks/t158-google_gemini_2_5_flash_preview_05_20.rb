def find_max(words)
  return "" if words.empty?

  max_word = ""
  max_unique_chars = -1

  words.each do |word|
    unique_chars_count = word.chars.uniq.count

    if unique_chars_count > max_unique_chars
      max_unique_chars = unique_chars_count
      max_word = word
    elsif unique_chars_count == max_unique_chars
      max_word = [max_word, word].min
    end
  end
  max_word
end