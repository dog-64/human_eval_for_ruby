def histogram(text)
  counts = Hash.new(0)
  text.each_char do |char|
    if char.match?(/[a-z]/)
      counts[char] += 1
    end
  end
  max_count = counts.values.max || 0
  counts.select { |_, v| v == max_count }
end