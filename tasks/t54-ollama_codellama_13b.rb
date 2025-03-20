def same_chars?(s0, s1)
  return false if s0.empty? || s1.empty?
  chars = s0.chars + s1.chars
  chars.uniq.size == 1 && chars.count(chars[0]) == chars.size
end