def prime_length?(string)
  n = string.length
  return false if n <= 1

  (2..Math.sqrt(n).to_i).each do |i|
    return false if n % i == 0
  end
  true
end