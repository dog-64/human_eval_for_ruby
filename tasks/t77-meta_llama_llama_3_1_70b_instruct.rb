def is_cube?(a)
  b = Math.round(Math.pow(a.abs, 1.0 / 3.0))
  b ** 3 == a.abs
end