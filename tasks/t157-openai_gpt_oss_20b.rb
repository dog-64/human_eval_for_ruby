def right_angle_triangle?(a, b, c)
  return false if [a, b, c].any? { |x| x <= 0 }
  return false unless a + b > c && a + c > b && b + c > a
  sides = [a, b, c].sort
  a2, b2, c2 = sides.map { |x| x * x }
  (c2 - a2 - b2).abs < 1e-10
end