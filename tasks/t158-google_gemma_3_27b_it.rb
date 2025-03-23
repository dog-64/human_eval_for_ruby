
def find_max(words)
  return "" if words.empty?

  max_unique_chars = 0
  result = ""

  words.each do |word|
    unique_chars = word.chars.uniq.count
    if unique_chars > max_unique_chars
      max_unique_chars = unique_chars
      result = word
    elsif unique_chars == max_unique_chars && word < result
      result = word
    end
  end

  result
end
