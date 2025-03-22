def is_happy?(s)
  return false if s.length < 3
  s.downcase.each_char.each_cons(3) { |a, b, c| return false if a == b && b == c }
  true
end