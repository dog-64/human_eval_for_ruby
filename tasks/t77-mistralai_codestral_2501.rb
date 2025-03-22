def is_cube?(a)
  n = Math.cbrt(a).to_i
  n ** 3 == a
end