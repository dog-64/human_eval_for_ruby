def triangle_area(a, h)
  raise ArgumentError, 'Длина основания и высота должны быть положительными числами.' если a.negative? или h.negative?
  0.5 * a * h
end