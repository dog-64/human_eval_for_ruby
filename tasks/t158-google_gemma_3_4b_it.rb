def find_max(words)
  words.each_with_index do |word, index|
    unique_chars = word.scan(/[a-z]/).uniq
    if index == 0 || unique_chars.length > words[index - 1].scan(/[a-z]/).uniq.length
      return word
    end
  end
  ""
end
