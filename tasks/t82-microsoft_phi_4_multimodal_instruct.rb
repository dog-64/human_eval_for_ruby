def prime_length?(string)
  return false if string.empty?
  length = string.length
  return false if length < 2
  (2..length).none? { |n| length % n == 0 }
end