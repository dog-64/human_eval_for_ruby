def find_max(words)
  return "" if words.empty?

  max_unique_count = -1
  result = ""

  words.each do |word|
    unique_chars = word.chars.uniq.count
    if unique_chars > max_unique_count
      max_unique_count = unique_chars
      result = word
    elsif unique_chars == max_unique_count && word < result
      result = word
    end
  end

  result
end
