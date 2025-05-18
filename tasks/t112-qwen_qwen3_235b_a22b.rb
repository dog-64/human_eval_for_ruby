def reverse_delete(s, c)
  filtered = s.chars.reject { |char| c.include?(char) }.join
  [filtered, filtered == filtered.reverse]
end