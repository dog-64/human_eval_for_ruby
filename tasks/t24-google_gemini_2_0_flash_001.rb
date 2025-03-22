def largest_divisor(n)
  return nil if n <= 1
  (n / 2).downto(1) do |i|
    if n % i == 0
      return i
    end
  end
  return nil
end