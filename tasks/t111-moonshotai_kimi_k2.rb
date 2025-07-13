def histogram(text)
  return {} if text.empty?
  
  counts = Hash.new(0)
  text.each_char do |char|
    counts[char] += 1 if char.match?(/[a-z]/)
  end
  
  return {} if counts.empty?
  
  max_count = counts.values.max
  counts.select { |_, count| count == max_count }
end