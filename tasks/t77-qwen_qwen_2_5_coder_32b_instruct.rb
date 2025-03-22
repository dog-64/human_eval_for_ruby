def is_cube?(a)
  cbrt = Math.cbrt(a).round
  cbrt**3 == a
end