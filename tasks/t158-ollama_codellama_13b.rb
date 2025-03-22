def find_max(words)
  return "" if words.empty?

  max_length = 0
  max_word = ""

  words.each do |word|
    length = word.chars.uniq.size
    if length > max_length
      max_length = length
      max_word = word
    elsif length == max_length && word < max_word
      max_word = word
    end
  end

  return max_word
end