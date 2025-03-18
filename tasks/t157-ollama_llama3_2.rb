def right_angle_triangle?(a, b, c)
  a, b, c = [a, b, c].sort
  (a + b > c) && (a**2 + b**2 == c**2)
end