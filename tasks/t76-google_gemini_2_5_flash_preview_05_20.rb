def is_simple_power?(x, n)
  return false if x < 0 || n < 0
  return false if n == 1 && x != 1
  return false if n == 0 && x != 1
  return true if x == 1 && n != 0

  current_power = n
  while current_power <= x
    return true if current_power == x
    return false if n == 0
    current_power *= n
  end
  false
end