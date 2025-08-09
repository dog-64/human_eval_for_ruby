def largest_divisor(n)
  return nil if n <= 1
  limit = Math.sqrt(n).floor
  (2..limit).each do |i|
    return n / i if n % i == 0
  end
  1
end