def largest_prime_factor(n)
  factor = 2
  largest_factor = 1
  while n > 1
    if n % factor == 0
      largest_factor = factor
      n /= factor
    else
      factor += 1
    end
  end
  largest_factor
end