def is_prime(num)
  return false if num < 2
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def count_up_to(n)
  primes = []
  return primes if n < 2
  (2...n).each do |i|
    primes << i if is_prime(i)
    break if primes.size >= n
  end
  primes
end