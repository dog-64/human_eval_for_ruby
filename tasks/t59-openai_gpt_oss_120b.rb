def largest_prime_factor(n)
  max_factor = 1
  while n % 2 == 0
    max_factor = 2
    n /= 2
  end
  i = 3
  while i * i <= n
    while n % i == 0
      max_factor = i
      n /= i
    end
    i += 2
  end
  max_factor = n if n > 1
  max_factor
end