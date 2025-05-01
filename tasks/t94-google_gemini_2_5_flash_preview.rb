require 'prime'

def sum_largest_prime_digits(numbers)
  largest_prime = numbers.select(&:prime?).max
  if largest_prime.nil?
    0
  else
    largest_prime.to_s.chars.map(&:to_i).sum
  end
end
