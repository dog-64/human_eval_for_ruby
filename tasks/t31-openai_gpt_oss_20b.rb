def is_prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n.even?
  limit = Math.sqrt(n).floor
  i = 3
  while i <= limit
    return false if n % i == 0
    i += 2
  end
  true
end