
def is_multiply_prime?(a)
  return false if a < 30

  factors = []
  temp = a
  d = 2
  while d * d <= temp
    if temp % d == 0
      factors << d
      temp /= d
      while temp % d == 0
        temp /= d
      end
    end
    d += 1
  end
  factors << temp if temp > 1

  return false if factors.size != 3

  product = factors.inject(1) { |prod, factor| prod * factor }
  product == a
end