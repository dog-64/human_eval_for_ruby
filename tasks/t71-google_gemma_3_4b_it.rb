def triangle_area(a, b, c)
  if a <= 0 || b <= 0 || c <= 0
    return -1
  end

  if a + b <= c || a + c <= b || b + c <= a
    return -1
  end

  s = (a + b + c) / 2
  area = Math.sqrt(s * (s - a) * (s - b) * (s - c))

  return area.round(2)
end
