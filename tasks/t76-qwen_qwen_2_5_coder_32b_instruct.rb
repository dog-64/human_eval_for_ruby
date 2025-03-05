def is_simple_power?(x, n)
  return false if x == 0 && n == 0
  return true if x == 1
  return false if n <= 1

  power = 1
  while power < x
    power *= n
    return true if power == x
  end

  false
end