def is_simple_power?(x, n)
  return false if n < 0 || x < 0
  return true if x == 1
  return false if n == 0 || n == 1
  power = 0
  while n**power < x
    power += 1
  end
  n**power == x
end