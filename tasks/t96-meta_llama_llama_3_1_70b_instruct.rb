def count_up_to(n)
  primes = []
  num = 2
  while primes.size < n
    is_prime = true
    (2..Math.sqrt(num)).each do |i|
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