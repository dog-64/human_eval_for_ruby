def largest_divisor(n)
  return nil if n <= 1
  if n.even?
    return n / 2
  end
  sqrt_n = Math.sqrt