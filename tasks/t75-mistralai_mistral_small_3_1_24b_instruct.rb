def is_multiply_prime?(a)
  return false if a < 2

  def prime?(n)
    return false if n < 2
    (2..Math.sqrt(n)).each do |i|
      return false if n % i == 0
    end
    true
  end

  def prime_factors(n)
    factors = []
    (2..n).each do |i|
      while n % i == 0 && prime?(i)
        factors << i
        n /= i
      end
    end
    factors
  end

  factors = prime_factors(a)
  factors.uniq.size == 3
end