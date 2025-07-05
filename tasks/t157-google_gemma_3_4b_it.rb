def right_angle_triangle?(a, b, c)
  a = a.to_f
  b = b.to_f
  c = c.to_f

  return false if a <= 0 || b <= 0 || c <= 0

  return false if a + b <= c || a + c <= b || b + c <= a

  a**2 + b**2 == c**2 || a**2 + c**2 == b**2 || b**2 + c**2 == a**2
end
