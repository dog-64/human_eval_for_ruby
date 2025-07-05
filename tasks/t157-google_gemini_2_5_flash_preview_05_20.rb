def right_angle_triangle?(a, b, c)
  sides = [a, b, c].sort
  x, y, z = sides[0], sides[1], sides[2]

  return false if x <= 0 || y <= 0 || z <= 0
  return false if x + y <= z

  (x**2 + y**2 - z**2).abs < 1e-9
end