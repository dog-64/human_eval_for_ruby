def largest_divisor(n)
  return nil if n <= 1
  (2...n).each do |i|
    return i if n % i == 0
  end
  1
end
