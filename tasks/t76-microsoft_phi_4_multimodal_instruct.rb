def is_simple_power?(x, n)
  return false if x == 0 && n == 0
  if n == 1
    return x == 1
  end
  if x < 1 || n < 1
    return false
  end
  int = 0
  while n**int <= x
    if n**int == x
      return true
    end
    int += 1
  end
  return false
end