def is_simple_power?(x, n)
  return false if x < 1 || n < 1
  int = 0
  while n**int < x
    int += 1
  end
  n**int == x
end