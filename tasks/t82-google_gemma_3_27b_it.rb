
def prime_length?(string)
  n = string.length
  return false if n <= 1
  i = 2
  while i * i <= n
    if n % i == 0
      return false
    i += 1
  end
  return true
end
