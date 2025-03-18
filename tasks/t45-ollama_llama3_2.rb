def triangle_area(a, h)
  raise ArgumentError, 'Длина основания и высота должны быть положительными' if a <= 0 || h <= 0
  (a * h) / 2
end