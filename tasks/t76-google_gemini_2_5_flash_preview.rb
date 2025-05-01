def is_simple_power?(x, n)
  return false if n == 0
  return true if x == 1 && n != 0
  return false if x <= 0

  power = 0
  while n**power <= x
    return true if n**power == x
    power += 1
  end
  false
end
