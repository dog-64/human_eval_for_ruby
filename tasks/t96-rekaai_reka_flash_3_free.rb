
def count_up_to(n)
  return [] if n <= 1

  sieve = Array.new(n, true)
  sieve[0] = sieve[1] = false

  (2..Math.sqrt(n-1)).each do |i|
    sieve[i] && (i*i).step(n-1, i) { |j| sieve[j] = false }
  end

  sieve.each_with_index.select { |prime, _| prime }.map(&:last).take(n)
end

 