def right_angle_triangle?(a, b, c)
  return false if a <= 0 || b <= 0 || c <= 0
  return false unless a + b > c && a + c > b && b + c > a
  [a, b, c].combination(2).any? { |x, y| (x**2 + y**2) == (c**2 - x**2 - y**2).abs**2 }
end