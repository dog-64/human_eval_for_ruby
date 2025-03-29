def triangle_area(a, h)
  a.positive? && h.positive? ? a * h / 2.0 : nil
end