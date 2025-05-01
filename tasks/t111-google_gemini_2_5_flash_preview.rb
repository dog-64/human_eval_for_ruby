def histogram(text)
  counts = Hash.new(0)
  text.each_char do |char|
    if ('a'..'z').include?(char)
      counts[char] += 1
    end
  end

  max_count = counts.values.max

  if max_count.nil?
    {}
  else
    counts.select { |_char, count| count == max_count }
  end
end
