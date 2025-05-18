def is_simple_power?(x, n)
  return false if x == 0 && n == 0
  return false if n == 0
  return true if x == 1
  current = n
  while current <= x
    return true if current == x
    current *= n
  end
  false
end