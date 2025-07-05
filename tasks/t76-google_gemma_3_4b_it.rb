def is_simple_power?(x, n)
  return false if x == 0 && n == 0
  return false if n == 0 || x < 0

  power = 0
  result = 1

  while result < x
    result *= n
    power += 1
  end

  result == x
end
