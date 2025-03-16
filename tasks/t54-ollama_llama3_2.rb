def same_chars?(s0, s1)
  (s0 + s1).split('').uniq.size == (s0 + s1).split('').size
end