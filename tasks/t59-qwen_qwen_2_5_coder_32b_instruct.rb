def largest_prime_factor(n)
  factor = 2
  while n > 1
    if n % factor == 0
      n /= factor
    else
      factor += 1
    end
  end
  factor
end