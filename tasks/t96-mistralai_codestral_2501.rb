def count_up_to(n)
  return [] if n < 2

  primes = []
  num = 2

  while primes.size < n
    is_prime = true
    Math.sqrt(num).to_i.downto(2) do |i|
      if num % i == 0
        is_prime = false
        break
      end
    end
    primes << num if is_prime
    num += 1
  end

  primes
end