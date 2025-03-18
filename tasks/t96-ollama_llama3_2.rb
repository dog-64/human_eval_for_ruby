def count_up_to(n)
  primes = []
  (2..n).each do |i|
    next if i % 2 == 0
    (3..Math.sqrt(i)).step(2).none? { |j| i % j != 0 } ? primes << i : nil
  end
  primes.compact
end