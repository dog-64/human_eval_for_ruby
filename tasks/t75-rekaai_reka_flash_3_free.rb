
def is_multiply_prime?(a)
  factors = Set.new
  divisor = 2
  n = a
  while divisor * divisor <= n
    while n % divisor == 0
      factors.add(divisor)
      n /= divisor
    end
    divisor += 1
  end
  factors.add(n) if n > 1
  factors.size == 3
end

 