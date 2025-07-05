def is_happy?(s)
  return false if s.length < 3
  s.chars.each_cons(3).all? { |a, b, c| a != b && b != c && a != c }
end