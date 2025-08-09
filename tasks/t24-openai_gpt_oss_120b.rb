def largest_divisor(n)
  return nil if n <= 1
  limit = Math.sqrt(n).to_i
  (2..limit).each do |i|
    if n % i == 0
      return n / i
    end
  end
  1
end