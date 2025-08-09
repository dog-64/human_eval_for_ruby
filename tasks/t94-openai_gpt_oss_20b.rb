def sum_largest_prime_digits(numbers)
  return 0 if numbers.empty?

  is_prime = lambda do |n|
    return false if n < 2
    return true if n == 2
    return false if n.even?
    limit = Math.sqrt(n).to_i
    i = 3
    while i <= limit
      return false if n % i == 0
      i += 2
    end
    true
  end

  primes = numbers.select { |num| is_prime.call(num) }
  return 0 if primes.empty?

  largest_prime = primes.max
  largest_prime.to_s.chars.map { |c| c.to_i }.sum
end