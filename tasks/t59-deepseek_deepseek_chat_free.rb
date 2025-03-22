def largest_prime_factor(n)
  factor = 2
  while factor * factor <= n
    if n % factor == 0
      n /= factor
    else
      factor += 1
    end
  end
  n
end