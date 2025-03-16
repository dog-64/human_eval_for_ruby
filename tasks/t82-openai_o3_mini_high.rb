def prime_length?(string)
  n = string.length
  return false if n < 2
  (2..Math.sqrt(n).floor).each do |i|
    return false if n % i == 0
  end
  true
end