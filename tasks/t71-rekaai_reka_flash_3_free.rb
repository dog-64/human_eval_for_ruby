
def triangle_area(a, b, c)
  return -1 if a <= 0 || b <= 0 || c <= 0
  sorted = [a, b, c].sort
  return -1 unless sorted[0] + sorted[1] > sorted[2]
  s = (a + b + c) / 2.0
  Math.sqrt(s * (s - a) * (s - b) * (s - c)).round(2)
end

 