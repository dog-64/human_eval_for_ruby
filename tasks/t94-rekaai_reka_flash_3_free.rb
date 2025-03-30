
def sum_largest_prime_digits(numbers)
  def is_prime?(n)
    return false if n <= 1
    return true if n == 2
    return false if n.even?
    sqrt_n = Math.sqrt(n).to_i
    (3..sqrt_n).step(2) { |i| return false if n % i == 0 }
    true
  end

  primes = numbers.select { |num| is_prime?(num) }
  return 0 if primes.empty?
  max_prime = primes.max
  max_prime.to_s.chars.map(&:to_i).sum
end

 