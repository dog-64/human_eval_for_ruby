def largest_divisor(n)
  return nil if n <= 1
  (1...n).reverse_each do |i|
    return i if n % i == 0
  end
end