def find_max(words)
  return "" if words.empty?
  counts = words.map { |w| [w, w.chars.select { |c| c =~ /[a-z]/ }.uniq.size] }
  max = counts.map { |_, c| c }.max
  candidates = counts.select { |_, c| c == max }.map { |w, _| w }
  candidates.min
end