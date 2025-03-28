def is_happy?(s)
  return false if s.length < 3

  s.each_cons(3).all? { |chunk| chunk.uniq.size == 3 }
end