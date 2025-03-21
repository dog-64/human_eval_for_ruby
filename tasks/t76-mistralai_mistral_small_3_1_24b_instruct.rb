def is_simple_power?(x, n)
  return false if x == 0 && n == 0
  return false if x == 1 && n == 0
  return false if x < 0 || n < 0

  return true if x == 1

  power = n
  while power < x
    power *= n
  end
  power == x
end