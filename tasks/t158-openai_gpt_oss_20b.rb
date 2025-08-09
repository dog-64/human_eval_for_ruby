def find_max(words)
  return "" if words.empty?
  stats = words.map do |w|
    uniq_count = w.chars.select { |c| c >= 'a' && c <= 'z' }.uniq.size
    [uniq_count, w]
  end
  max_count = stats.map(&:first).max
  candidates = stats.select { |c, _| c == max_count }.map(&:last)
  candidates.min
end