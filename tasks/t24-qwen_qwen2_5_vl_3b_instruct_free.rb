def largest_divisor(n)
  return nil if n <= 1
  (n - 1).downto(1).each do |divisor|
    return divisor if n % divisor == 0
  end
  nil
end