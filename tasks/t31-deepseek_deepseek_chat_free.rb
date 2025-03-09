def is_prime?(n)
  return false if n <= 1
  return true if n <= 3
  return false if n % 2 == 0 || n % 3 == 0
  i = 5
  while i * i <= n
    return false if n % i == 0 || n % (i + 2) == 0
    i += 6
  end
  true
end
