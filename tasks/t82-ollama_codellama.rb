def prime_length?(string)
  length = string.length
  (2..length).any? { |i| length % i == 0 }
end