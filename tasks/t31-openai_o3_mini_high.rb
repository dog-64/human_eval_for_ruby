def is_prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n % 2 == 0
  limit = Math.sqrt(n).to_i
  divisor = 3
  while divisor <= limit
    return false if n % divisor == 0
    divisor += 2
  end
  true
end