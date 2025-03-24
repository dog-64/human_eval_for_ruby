def largest_divisor(n)
  return nil if n <= 1
  (1...n).find { |i| n % i == 0 }
end