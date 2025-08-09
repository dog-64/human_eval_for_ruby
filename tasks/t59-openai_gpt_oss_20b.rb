def largest_prime_factor(n)
  largest = nil
  i = 2
  while i * i <= n
    while n % i == 0
      largest = i
      n /= i
    end
    i += 1
  end
  largest = n if n > 1
  largest
end