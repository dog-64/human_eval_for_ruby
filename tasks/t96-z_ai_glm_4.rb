def count_up_to(n)
  return [] if n <= 1

  sieve = Array.new(n, true)
  sieve[0] = false
  sieve[1] = false

  (2..Math.sqrt(n).to_i).each do |i|
    if sieve[i]
      (i * i...n).step(i) do |j|
        sieve[j] = false
      end
    end
  end

  primes = []
  (2...n).each do |i|
    primes << i if sieve[i]
  end

  primes
end