def histogram(text)
  counts = Hash.new(0)
  text.downcase.each_char do |char|
    if ('a'..'z').include?(char)
      counts[char] += 1
    end
  end

  max_count = counts.values.max
  if max_count.nil?
    return {}
  end
  
  result = {}
  counts.each do |char, count|
    if count == max_count
      result[char] = count
    end
  end
  result
end