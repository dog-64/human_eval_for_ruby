def right_angle_triangle?(a, b, c)
  return false if [a, b, c].any? { |x| x <= 0 }
  return false unless (a + b > c) && (a + c > b) && (b + c > a)
  [a**2 + b**2 == c**2, a**2 + c**2 == b**2, b**2 + c**2 == a**2].any?
end