def is_simple_power?(x, n)
  return false if x < 0 || n < 0 || (x == 0 && n == 0) || (x == 1 && n == 0)

  return true if x == 1

  i = 1
  while n**i <= x
    return true if n**i == x
    i += 1
  end

  false
end
