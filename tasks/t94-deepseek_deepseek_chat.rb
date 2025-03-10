def is_prime(n)
  return false if n < 2
  (2..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end
  true
end

def sum_digits(n)
  n.to_s.chars.map(&:to_i).sum
end

def sum_largest_prime_digits(numbers)
  primes = numbers.select { |num| is_prime(num) }
  return 0 if primes.empty?
  largest_prime = primes.max
  sum_digits(largest_prime)
end