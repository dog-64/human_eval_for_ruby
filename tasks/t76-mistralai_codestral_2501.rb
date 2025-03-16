def is_simple_power?(x, n)
  return false if n <= 1 || x <= 0
  while x % n == 0
    x /= n
  end
  x == 1
end