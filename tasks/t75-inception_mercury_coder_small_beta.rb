def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end

def is_multiply_prime?(a)
  primes = (2...a).select { |n| is_prime?(n) }
  primes.combination(3).any? { |p1, p2, p3| p1 * p2 * p3 == a }
end