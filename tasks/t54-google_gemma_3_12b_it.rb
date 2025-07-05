def same_chars?(s0, s1)
  s0_chars = s0.downcase.chars.sort
  s1_chars = s1.downcase.chars.sort
  s0_chars == s1_chars
end
