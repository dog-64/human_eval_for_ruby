def triangle_area(a, b, c)
  return -1 if a + b <= c || b + c <= a || a + c <= b
  s = (a + b + c) / 2
  Math.sqrt(s * (s - a) * (s - b) * (s - c))
end