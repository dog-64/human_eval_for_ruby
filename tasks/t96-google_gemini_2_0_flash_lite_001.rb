def count_up_to(n)
  return [] if n <= 1

  primes = []
  num = 2
  while primes.length < n
    is_prime = true
    (2..Math.sqrt(num)).each do |i|
      if num % i == 0
        is_prime = false
        break
      end
    end
    if is_prime
      primes << num
    end
    num += 1
    if num >= n && primes.length < n
      break
    end
  end
  primes
end