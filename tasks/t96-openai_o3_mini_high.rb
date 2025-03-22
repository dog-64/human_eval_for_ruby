def count_up_to(n)
  return [] if n < 2
  primes = []
  (2...n).each do |i|
    is_prime = true
    (2..Math.sqrt(i).to_i).each do |j|
      if i % j == 0
        is_prime = false
        break
      end
    end
    if is_prime
      primes << i
      break if primes.size == n
    end
  end
  primes
end