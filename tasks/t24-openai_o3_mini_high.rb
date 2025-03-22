def largest_divisor(n)
  return nil if n <= 1
  (n / 2).downto(1) do |d|
    return d if (n % d).zero?
  end
end