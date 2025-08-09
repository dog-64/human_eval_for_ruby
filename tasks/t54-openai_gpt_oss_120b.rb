def same_chars?(s0, s1)
  require 'set'
  Set.new(s0.downcase.chars) == Set.new(s1.downcase.chars)
end