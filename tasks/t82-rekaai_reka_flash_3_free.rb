
def prime_length?(string)
  length = string.length
  return false if length == 0
  (2..Math.sqrt(length).to_i).all? { |i| length % i != 0 } && length > 1
end

 