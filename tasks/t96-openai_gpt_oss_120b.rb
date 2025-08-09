def count_up_to(n)
  return [] if n <= 2
  primes = []
  (2...n).each do |i|
    is_prime = true
    limit = Math.sqrt(i).to_i
    primes.each do |p|
      break if p > limit
      if i % p == 0
        is_prime = false
        break
      end
    end
    primes << i if is_prime
  end
  primes
end