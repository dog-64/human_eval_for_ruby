def histogram(text)
  counts = Hash.new(0)
  text.each_char do |ch|
    counts[ch] += 1 if ch =~ /[a-z]/
  end
  return {} if counts.empty?
  max_freq = counts.values.max
  counts.select { |_, v| v == max_freq }
end