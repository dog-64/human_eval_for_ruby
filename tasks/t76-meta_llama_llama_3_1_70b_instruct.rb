def is_simple_power?(x, n)
  return false if x == 0 && n == 0
  i = 0
  while n ** i <= x
    return true if n ** i == x
    i += 1
  end
  false
end