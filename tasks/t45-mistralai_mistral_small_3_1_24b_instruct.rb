def triangle_area(a, h)
  raise ArgumentError, "Both a and h must be positive numbers" if a <= 0 || h <= 0
  (a * h) / 2.0
end