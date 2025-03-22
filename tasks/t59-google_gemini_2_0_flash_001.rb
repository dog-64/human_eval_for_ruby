def largest_prime_factor(n)
  i = 2
  while i * i <= n
    while n % i == 0
      n /= i
    end
    i += 1
  end
  if n > 1
    return n
  else
    return i - 1
  end
end