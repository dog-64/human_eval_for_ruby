require 'prime'

def sum_largest_prime_digits(numbers)
  largest_prime = numbers.select(&:prime?).max

  if largest_prime.nil?
    0
  else
    largest_prime.digits.sum
  end
end