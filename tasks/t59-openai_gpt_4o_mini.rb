def largest_prime_factor(n)
  factor = 2
  largest = 0

  while n > 1
    if n % factor == 0
      largest = factor
      n /= factor
    else
      factor += 1
    end
  end

  largest
end