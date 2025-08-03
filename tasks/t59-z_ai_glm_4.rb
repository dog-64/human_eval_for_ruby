
def largest_prime_factor(n)
  largest_prime = -1

  while n % 2 == 0
    largest_prime = 2
    n /= 2
  end

  factor = 3
  while factor * factor <= n
    while n % factor == 0
      largest_prime = factor
      n /= factor
    end
    factor += 2
  end

  if n > 1
    largest_prime = n
  end

  largest_prime
end