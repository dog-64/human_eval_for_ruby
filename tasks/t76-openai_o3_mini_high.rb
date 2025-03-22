def is_simple_power?(x, n)
  return false if x < 0 || n < 0
  return false if n == 0
  return true if x == 1
  return false if n == 1
  power = 1
  while power <= x
    return true if power == x
    power *= n
  end
  false
end