def prime_length?(string)
  len = string.length
  return false if len < 2
  i = 2
  while i * i <= len
    return false if len % i == 0
    i += 1
  end
  true
end