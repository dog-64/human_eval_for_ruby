def prime_length?(string)
  len = string.length
  return false if len <= 1
  return false if len.even? && len != 2
  i = 3
  while i * i <= len
    return false if len % i == 0
    i += 2
  end
  true
end