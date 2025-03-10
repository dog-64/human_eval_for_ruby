def right_angle_triangle?(a, b, c)
  sides = [a, b, c].sort
  return false if sides[0] <= 0 || sides[1] <= 0 || sides[2] <= 0
  return false if sides[0] + sides[1] <= sides[2]
  sides[0]**2 + sides[1]**2 == sides[2]**2
end