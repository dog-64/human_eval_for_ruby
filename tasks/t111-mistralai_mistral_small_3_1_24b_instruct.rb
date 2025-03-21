def histogram(text)
  counts = Hash.new(0)
  text.each_char do |char|
    counts[char] += 1 if char =~ /[a-z]/
  end
  counts.select { |_, count| count == counts.values.max }
end