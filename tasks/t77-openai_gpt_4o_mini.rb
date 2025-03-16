def is_cube?(a)
  return false if a < 0 && a != -1
  n = a ** (1.0 / 3).round
  n**3 == a || (n + 1)**3 == a || (n - 1)**3 == a
end