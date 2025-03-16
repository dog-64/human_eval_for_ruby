def right_angle_triangle?(a, b, c)
  return false if [a, b, c].any? { |side| side <= 0 }
  sides = [a, b, c].sort
  sides[0]**2 + sides[1]**2 == sides[2]**2
end