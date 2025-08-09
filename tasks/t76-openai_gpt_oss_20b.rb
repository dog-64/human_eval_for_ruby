def is_simple_power?(x, n)
  return false if x < 0 || n < 0
  return false if n == 0
  return true if x == 1 && n != 0
  return false if x == 0
  return x == 1 if n == 1
  while x % n == 0
    x /= n
  end
  x == 1
end