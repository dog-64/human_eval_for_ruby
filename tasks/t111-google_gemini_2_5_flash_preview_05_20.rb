def histogram(text)
  counts = Hash.new(0)
  text.each_char do |char|
    if char.match?(/[a-z]/)
      counts[char] += 1
    end
  end

  return {} if counts.empty?

  max_frequency = counts.values.max
  
  result = {}
  counts.each do |char, count|
    if count == max_frequency
      result[char] = count
    end
  end
  result
end