def count_up_to(n)
  primes = []
  (2...n).each do |num|
    primes << num if is_prime?(num)
  end
  primes[0, n]
end

def is_prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end