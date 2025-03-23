def is_simple_power?(x, n)
  return false if n == 0
  return true if x == 1 && n != 1
  return false if x == 0 && n == 0
  return false if x < 0

  if n == 1
    return x == 1
  end

  i = 0
  while n**i <= x
    if n**i == x
      return true
    end
    i += 1
  end

  return false
end