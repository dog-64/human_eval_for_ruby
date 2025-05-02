def largest_prime_factor(n)
  largest = 1

  while n % 2 == 0
    largest = 2
    n /= 2
  end

  i = 3
  while i * i <= n