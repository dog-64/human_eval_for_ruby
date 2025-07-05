def prime_length?(string)
  len = string.length
  return false if len < 2
  (2..Math.sqrt(len)).none? { |i| len % i == 0 }
end