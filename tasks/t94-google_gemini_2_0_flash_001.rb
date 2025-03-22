def sum_largest_prime_digits(numbers)
  primes = numbers.select { |n| is_prime?(n) }
  return 0 if primes.empty?

  largest_prime = primes.max
  largest_prime.to_s.chars.map(&:to_i).sum
end

def is_prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end
  true
end