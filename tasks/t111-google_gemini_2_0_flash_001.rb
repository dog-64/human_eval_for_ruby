def histogram(text)
  counts = Hash.new(0)
  text.each_char do |char|
    if char =~ /[a-z]/
      counts[char] += 1
    end
  end

  max_count = counts.values.max
  
  result = {}
  counts.each do |char, count|
    if count == max_count
      result[char] = count
    end
  end

  return result
end