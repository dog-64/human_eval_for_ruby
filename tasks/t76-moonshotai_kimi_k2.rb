def is_simple_power?(x, n)
  return false if x < 1 || n < 1
  return true if x == 1
  return false if n == 1
  
  current = n
  while current <= x
    return true if current == x
    current *= n
  end
  
  false
end