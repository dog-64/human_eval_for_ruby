def count_up_to(n)
  return [] if n <= 1
  primes = [2]
  (3..n).step(2) { |i| primes << i unless primes.any? { |p| i % p == 0 } }
  primes
end