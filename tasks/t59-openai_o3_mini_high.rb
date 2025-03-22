def largest_prime_factor(n)
  factor = 2
  largest = nil
  while n > 1
    if n % factor == 0
      largest = factor
      n /= factor while n % factor == 0
    else
      factor += 1
    end
  end
  largest
end