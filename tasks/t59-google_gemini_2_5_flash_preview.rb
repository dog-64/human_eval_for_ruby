def largest_prime_factor(n)
  i = 2
  largest_factor = 1
  while i * i <= n
    if n % i == 0
      largest_factor = i
      while n % i == 0
        n /= i
      end
    end
    i += 1
  end
  if n > 1
    largest_factor = n
  end
  largest_factor
end