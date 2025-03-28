def is_simple_power?(x, n)
  return false if x <= 0 || n <= 0
  return true if x == 1

  power = 0
  current = 1

  while current <= x
    return true if current == x
    current *= n
    power += 1
  end

  false
end