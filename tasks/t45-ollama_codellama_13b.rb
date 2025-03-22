def triangle_area(a, h)
  raise ArgumentError, "Invalid input" unless a > 0 && h > 0
  (a * h / 2).to_f
end