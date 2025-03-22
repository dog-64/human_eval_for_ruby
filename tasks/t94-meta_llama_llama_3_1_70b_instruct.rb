def is_prime(n)
  return false if n < 2
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def sum_largest_prime_digits(numbers)
  prime_numbers = numbers.select { |n| is_prime(n) }
  return 0 if prime_numbers.empty?
  max_prime = prime_numbers.max
  max_prime.to_s.chars.map(&:to_i).sum
end