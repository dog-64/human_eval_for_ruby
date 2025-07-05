def largest_divisor(n)
  return nil if n <= 1
  for i in (2..n / 2)
    if n % i == 0
      return i
    end
  end
  1
end
