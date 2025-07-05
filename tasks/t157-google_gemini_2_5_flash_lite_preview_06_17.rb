def right_angle_triangle?(a, b, c)
  sides = [a, b, c].sort
  x, y, z = sides
  return false if x <= 0
  return false unless x + y > z
  (x**2 + y**2) == z**2
end