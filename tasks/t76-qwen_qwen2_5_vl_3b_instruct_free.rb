def is_simple_power?(x, n)
  return false if x == 0 || n == 0 || x == 1 || n == 1
  return true if x == n

  int = 1
  while int ** n <= x
    return true if int ** n == x
    int += 1
  end
  false
end