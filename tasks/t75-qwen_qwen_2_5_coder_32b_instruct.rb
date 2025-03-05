def is_multiply_prime?(a)
  return false if a < 2

  primes = (2..99).select { |num| (2..Math.sqrt(num)).all? { |i| num % i != 0 } }

  primes.combination(3).any? { |p1, p2, p3| p1 * p2 * p3 == a }
end