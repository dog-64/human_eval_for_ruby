def count_up_to(n)
  return [] if n < 2
  primes = []
  (2...n).each do |num|
    is_prime = true
    (2..Math.sqrt(num)).each do |i|
      if num % i == 0
        is_prime = false
        break
      end
    end
    primes << num if is_prime
    break if primes.size == n
  end
  primes
end