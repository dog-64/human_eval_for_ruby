def histogram(text)
  counts = {}
  text.split.each do |word|
    word.each_char do |char|
      char = char.downcase
      if char =~ /[a-z]/
        counts[char] ||= 0
        counts[char] += 1
      end
    end
  end

  counts
end
