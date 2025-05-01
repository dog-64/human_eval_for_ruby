def count_up_to(n)
  return [] if n <= 1

  primes = []
  num = 2
  while num < n
    is_prime = true
    i = 2
    while i * i <= num
      if num % i == 0
        is_prime = false
        break
      end
      i += 1
    end
    primes << num if is_prime
    num += 1
  end
  primes
end