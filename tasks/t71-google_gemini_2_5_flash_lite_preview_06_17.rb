def triangle_area(a, b, c)
  return -1 if a <= 0 || b <= 0 || c <= 0
  return -1 unless (a + b > c) && (a + c > b) && (b + c > a)
  
  s = (a + b + c) / 2.0
  area = Math.sqrt(s * (s - a) * (s - b) * (s - c))
  
  (area * 100).round / 100.0
end