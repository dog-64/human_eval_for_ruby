def largest_prime_factor(n)
  factor = 2
  last_factor = 1

  while n > 1
    if n % factor == 0
      last_factor = factor
      n /= factor
    else
      factor += 1
    end
  end

  last_factor
end