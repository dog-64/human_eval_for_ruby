def largest_prime_factor(n)
  factor = 2
  while factor * factor <= n
    while n % factor == 0
      n /= factor
    end
    factor += 1
  end
  n
end