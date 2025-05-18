def histogram(text)
  letters = text.chars.select { |c| c.between?('a', 'z') }
  freq = letters.tally
  return {} if freq.empty?
  max_count = freq.values.max
  freq.select { |k, v| v == max_count }
end