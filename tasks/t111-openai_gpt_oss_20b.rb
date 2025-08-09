def histogram(text)
  counts = Hash.new(0)
  text.each_char do |ch|
    counts[ch] += 1 if ch =~ /[a-z]/
  end
  max_freq = counts.values.max
  return {} unless max_freq && max_freq > 0
  result = {}
  counts.each do |letter, freq|
    result[letter] = freq if freq == max_freq
  end
  result
end