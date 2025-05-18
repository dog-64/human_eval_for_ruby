def sum_largest_prime_digits(numbers)
  prime_numbers = numbers.select { |num| prime?(num) }
  largest_prime = prime_numbers.max
  largest_prime ? digit_sum(largest_prime) : 0
end

def prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end

def digit_sum(num)
  num.to_s.chars.map(&:to_i).sum
end