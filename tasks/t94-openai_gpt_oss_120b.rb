def prime?(n)
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

def sum_largest_prime_digits(numbers)
  max_prime = numbers.select { |num| prime?(num) }.max
  return 0 unless max_prime
  max_prime.to_s.chars.map { |c| c.to_i }.sum
end