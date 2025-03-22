def intersection(interval1, interval2)
  a, b = interval1
  c, d = interval2
  x = [a, c].max
  y = [b, d].min
  return "NO" if x > y
  (x..y).map { |i| i + 1 }.any? { |n| n * n == n } ? "YES" : "NO"
end