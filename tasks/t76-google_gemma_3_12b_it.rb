def is_simple_power?(x, n)
  return false if x < 0 || n < 0
  return false if n == 0 && x != 1
  return true if x == 1 && n == 1
  return false if n == 1 && x != 1
  return false if x == 0 && n != 1
  
  power = 0
  result = 1
  while result < x
    result *= n
    power += 1
  end
  
  result == x
end
