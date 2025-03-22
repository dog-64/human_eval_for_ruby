def histogram(text)
  hash = {}
  text.split.each do |word|
    word.chars.each do |char|
      next if char != ?a..?z
      hash[char] ||= 0
      hash[char] += 1
    end
  end
  hash
end