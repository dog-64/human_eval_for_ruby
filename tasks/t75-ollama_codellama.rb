def is_multiply_prime?(a)
  return false if a >= 100 || !a.is_a?(Integer)

  prime_factors = []

  (2..Math.sqrt(a)).step(2) do |i|
    next unless a % i == 0
    prime_factors << i
    break if prime_factors.size == 3
  end

  prime_factors.size == 3 && prime_factors.uniq.size == 3
end