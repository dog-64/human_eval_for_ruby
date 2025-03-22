def sum_largest_prime_digits(numbers)
  require 'prime'
  primes = numbers.select { |n| Prime.prime?(n) }
  return 0 if primes.empty?
  largest = primes.max
  largest.digits.sum
end