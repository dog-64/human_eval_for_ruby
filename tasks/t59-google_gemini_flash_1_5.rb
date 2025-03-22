def largest_prime_factor(n)
  i = 2
  largest_prime = 1
  while i * i <= n
    while n % i == 0
      largest_prime = i
      n /= i
    end
    i += 1
  end
  if n > 1
    largest_prime = n
  end
  largest_prime
end
