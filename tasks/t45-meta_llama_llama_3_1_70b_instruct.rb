def triangle_area(a, h)
  raise ArgumentError, 'Both a and h must be positive' if a <= 0 || h <= 0
  0.5 * a * h
end