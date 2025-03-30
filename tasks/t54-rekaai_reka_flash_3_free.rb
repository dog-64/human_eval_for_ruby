
def same_chars?(s0, s1)
  s0.downcase.chars.uniq.sort == s1.downcase.chars.uniq.sort
end

 