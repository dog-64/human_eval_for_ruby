def is_multiply_prime?(a)
  def prime_factors(n)
    i = 2
    factors = []
    while i * i <= n
      if n % i == 0
        factors << i
        n /= i
      else
        i += 1
      end
    end
    factors << n if n > 1
    factors
  end

  factors = prime_factors(a)
  factors.uniq.size == 3 && factors.reduce(&:*) == a
end