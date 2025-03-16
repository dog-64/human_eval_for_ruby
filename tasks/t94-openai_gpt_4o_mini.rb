def sum_largest_prime_digits(numbers)
  require 'prime'
  
  largest_prime = numbers.select(&:prime?).max
  return 0 unless largest_prime
  
  largest_prime.digits.sum
end