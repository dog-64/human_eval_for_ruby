def prime_length?(string)
  length = string.length
  return false if length <= 1
  return false if length == 2
  (2...length).each do |i|
    return false if length % i == 0
  end
  true
end
