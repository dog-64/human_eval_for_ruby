
def largest_divisor(n)
  return nil if n <= 1
  i = (n / 2).to_i
  (i.downto(2) do |i|
    return i if n % i == 0
  end)
  1
end

 