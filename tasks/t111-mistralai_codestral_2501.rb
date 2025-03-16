def histogram(text)
  frequency = Hash.new(0)
  text.each_char do |char|
    frequency[char] += 1 if char.match?(/[a-z]/)
  end
  frequency
end