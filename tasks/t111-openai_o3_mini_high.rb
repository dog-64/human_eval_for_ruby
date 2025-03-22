def histogram(text)
  counts = text.scan(/[a-z]/).tally
  return {} if counts.empty?
  max = counts.values.max
  counts.select { |_, count| count == max }
end