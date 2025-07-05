def is_simple_power?(x, n)
  return false if n == 0 && x != 1
  return false if n == 1 && x != 1
  return false if x < 0 || n < 0
  return true if x == 1
  return false if n == 0
  
  power = 0
  current_value = 1
  
  while current_value < x
    current_value *= n
    power += 1
  end
  
  current_value == x
end