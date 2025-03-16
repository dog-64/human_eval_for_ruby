def right_angle_triangle?(a, b, c)
  return false if a <= 0 || b <= 0 || c <= 0
  return false if a + b <= c || a + c <= b || b + c <= a

  sides = [a, b, c].sort
  sides[0]**2 + sides[1]**2 == sides[2]**2
end