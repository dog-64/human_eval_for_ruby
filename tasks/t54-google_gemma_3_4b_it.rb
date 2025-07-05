def same_chars?(s0, s1)
  s0.chars.all? { |char| s1.include?(char) }
end
