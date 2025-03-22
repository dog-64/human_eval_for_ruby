def largest_divisor(n)
  return nil if n <= 1
  (n - 1).downto(1) do |i|
    return i if n % i == 0
  end
end