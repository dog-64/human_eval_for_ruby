def largest_prime_factor(n)
  largest_factor = 1
  divisor = 2

  while divisor * divisor <= n
    while n % divisor == 0
      largest_factor = divisor
      n /= divisor
    end
    divisor += 1
  end

  if n > 1
    largest_factor = n
  end

  largest_factor
end
