def histogram(text)
  counts = Hash.new(0)
  text.each_char do |char|
    if char >= 'a' && char <= 'z'
      counts[char] += 1
    end
  end
  counts
end