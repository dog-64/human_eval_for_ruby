def largest_prime_factor(n)
  largest_factor = 1
  i = 2

  while i * i <= n
    while n % i == 0
      largest_factor = i
      n /= i
    end
    i += 1
  end

  if n > 1
    largest_factor = n
  end

  largest_factor
end
