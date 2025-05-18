def same_chars?(s0, s1)
  s0.downcase.chars.sort == s1.downcase.chars.sort
end