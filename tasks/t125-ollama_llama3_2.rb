def split_words(txt)
  if txt.empty?
    return []
  end
  words = txt.split(/[\s,]/)
  result = []
  (0...words.size).each do |i|
    if i.even?
      result << words[i].downcase.chars.map { |c| c.ord - ord('a') }.sum
    else
      result << words[i]
    end
  end
  result
end