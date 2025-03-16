def largest_divisor(n)
  return nil if n <= 1
  (2..n).find { |d| n % d == 0 }
end