def count_up_to(n)
  return [] if n <= 1
  sieve = Array.new(n, true)
  sieve[0] = sieve[1] = false if n > 1
  limit = Math.sqrt(n - 1).to_i
  (2..limit).each do |i|
    next unless sieve[i]
    (i * i).step(n - 1, i) { |j| sieve[j] = false }
  end
  primes = []
  (2...n).each { |i| primes << i if sieve[i] }
  primes
end