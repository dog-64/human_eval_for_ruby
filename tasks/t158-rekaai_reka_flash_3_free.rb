
def find_max(words)
  return "" if words.empty?

  max_count = -1
  result_word = ''

  words.each do |word|
    cleaned = word.gsub(/[^a-z]/, '')
    count = cleaned.chars.uniq.size

    if count > max_count
      max_count = count
      result_word = cleaned
    elsif count == max_count
      result_word = [cleaned, result_word].min
    end
  end

  result_word
end

 