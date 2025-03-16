def is_multiply_prime?(a)
  return false if a < 30

  primes = []
  (2..a).each do |num|
    primes << num if (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  prime_factors = []
  primes.each do |prime|
    while a % prime == 0
      prime_factors << prime
      a /= prime
    end
  end

  prime_factors.uniq.size == 3 && prime_factors.size == 3
end