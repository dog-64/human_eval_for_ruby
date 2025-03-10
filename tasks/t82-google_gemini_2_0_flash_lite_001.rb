def prime_length?(string)
  length = string.length
  return false if length <= 1

  (2..Math.sqrt(length)).none? { |i| length % i == 0 }
end