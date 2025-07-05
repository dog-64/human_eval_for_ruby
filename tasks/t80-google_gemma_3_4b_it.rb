def is_happy?(s)
  s.length >= 3 && !s.chars.any? { |char| s.chars.include?(char * 3) }
end
