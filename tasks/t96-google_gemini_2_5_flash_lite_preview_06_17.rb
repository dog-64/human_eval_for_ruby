def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end

def count_up_to(n)
  return [] if n <= 2
  primes = []
  num = 2
  while primes.length < n
    primes << num if is_prime?(num)
    num += 1
  end
  primes
end