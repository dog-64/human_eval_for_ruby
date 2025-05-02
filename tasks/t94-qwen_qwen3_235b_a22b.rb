def sum_largest_prime_digits(numbers)
  primes = numbers.select do |n|
    next false if n < 2
    max_divisor = Math.sqrt(n).floor
    (2..max_divisor).none? { |d| n % d == 0 }
  end
  return 0 if primes.empty?
  max_prime = primes.max
  max_prime.to_s.chars.map(&:to_i).sum
end