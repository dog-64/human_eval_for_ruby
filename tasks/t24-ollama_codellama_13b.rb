def largest_divisor(n)
  return nil if n <= 1
  (2..n).find { |i| n % i == 0 }
end
largest_divisor(15)  # => 5
largest_divisor(12)  # => 6
largest_divisor(7)   # => 1
largest_divisor(1)   # => nil
largest_divisor(0)   # => nil