def count_up_to(n)
  return [] if n <= 2
  
  primes = []
  candidate = 2
  
  while candidate < n
    is_prime = true
    
    primes.each do |prime|
      break if prime * prime > candidate
      if candidate % prime == 0
        is_prime = false
        break
      end
    end
    
    primes << candidate if is_prime
    candidate += 1
  end
  
  primes
end