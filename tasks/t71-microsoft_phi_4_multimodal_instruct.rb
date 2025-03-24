def triangle_area(a, b, c)
  если a + b > c && a + c > b && b + c > a
    s = (a + b + c) / 2.0
    Math.sqrt(s * (s - a) * (s - b) * (s - c)).round(2)
  иначе
    -1
  end
end