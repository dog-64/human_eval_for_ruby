def is_simple_power?(x, n)
  return false if n <= 0 || x < 0
  return true if x == 1
  return false if n == 1

  power = 0
  current = n

  while current <= x
    if current == x
      return true
    end
    if current > x / n.to_f
        break
    end
    current *= n
  end

  false
end