def triangle_area(a, b, c)
  return -1 if [a, b, c].any? { |side| side <= 0 }
  return -1 unless a + b > c && a + c > b && b + c > a
  
  s = (a + b + c) / 2.0
  area = Math.sqrt(s * (s - a) * (s - b) * (s - c))
  area.round(2)
end