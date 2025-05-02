def is_happy?(s)
  return false if s.length < 3

  s_lower = s.downcase
  s_lower.each_char.each_cons(3) do |a, b, c|
    return false if a == b || b == c || a == c
  end
  true
end