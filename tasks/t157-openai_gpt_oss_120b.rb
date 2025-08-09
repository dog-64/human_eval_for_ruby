def right_angle_triangle?(a, b, c)
  return false unless a > 0 && b > 0 && c > 0
  return false unless a + b > c && a + c > b && b + c > a
  sides = [a, b, c].sort
  x, y, z = sides
  ((x * x) + (y * y) - (z * z)).abs < 1e-9
end