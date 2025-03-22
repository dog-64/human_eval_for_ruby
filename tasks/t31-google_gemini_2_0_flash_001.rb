def is_prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n % 2 == 0

  i = 3
  while i * i <= n
    return false if n % i == 0
    i += 2
  end

  return true
end