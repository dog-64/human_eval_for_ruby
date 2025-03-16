def is_cube?(a)
  b = Math.cbrt(a).round
  b**3 == a
end