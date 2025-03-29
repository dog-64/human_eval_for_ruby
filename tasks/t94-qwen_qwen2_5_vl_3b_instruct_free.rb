def sum_largest_prime_digits(numbers)
  largest_prime = numbers.select { |num| num.prime? }.max
  largest_prime ? largest_prime.to_s.chars.map(&:to_i).sum : 0
end