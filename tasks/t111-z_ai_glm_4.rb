def histogram(text)
  freq = Hash.new(0)
  text.each_char do |char|
    freq[char] += 1 if ('a'..'z').include?(char)
  end
  return {} if freq.empty?
  max_freq = freq.values.max
  freq.select { |_, count| count == max_freq }
end