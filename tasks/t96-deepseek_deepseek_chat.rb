def is_prime(num)
  return false if num <= 1
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def count_up_to(n)
  primes = []
  i = 2
  while i < n && primes.size < n
    primes << i if is_prime(i)
    i += 1
  end
  primes
end