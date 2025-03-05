def largest_divisor(n)
  return nil if n <= 1
  (2..Math.sqrt(n)).reverse_each do |i|
    return n / i if n % i == 0
  end
  1
end
