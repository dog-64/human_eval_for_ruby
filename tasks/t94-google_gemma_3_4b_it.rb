def sum_largest_prime_digits(numbers)
  primes = []
  numbers.each do |num|
    if num > 1 && is_prime?(num)
      primes << num
    end
  end

  if primes.empty?
    return 0
  end

  largest_prime = primes.max
  sum_of_digits = largest_prime.to_s.chars.map(&:to_i).sum
  sum_of_digits
end

def is_prime?(num)
  if num <= 1
    return false
  end
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end
