def sum_largest_prime_digits(numbers)
  primes = numbers.select { |n| prime?(n) }
  return 0 if primes.empty?
  max_prime = primes.max
  max_prime.to_s.chars.map(&:to_i).sum
end

def prime?(n)
  return false if n <= 1
  return true if n == 2
  (2..Math.sqrt(n).to_i).none? { |i| n % i == 0 }
end