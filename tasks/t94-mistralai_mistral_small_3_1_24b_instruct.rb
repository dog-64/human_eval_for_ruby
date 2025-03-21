def prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def sum_of_digits(num)
  num.to_s.chars.map(&:to_i).sum
end

def sum_largest_prime_digits(numbers)
  primes = numbers.select { |num| prime?(num) }
  return 0 if primes.empty?
  largest_prime = primes.max
  sum_of_digits(largest_prime)
end