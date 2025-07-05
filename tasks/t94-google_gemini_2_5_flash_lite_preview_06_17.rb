def is_prime(n)
  return false if n <= 1
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def sum_digits(n)
  n.to_s.chars.map(&:to_i).sum
end

def sum_largest_prime_digits(numbers)
  prime_numbers = numbers.select { |num| is_prime(num) }
  return 0 if prime_numbers.empty?
  largest_prime = prime_numbers.max
  sum_digits(largest_prime)
end