def prime_length?(string)
  n = string.length
  return false if n <= 1
  return true if n == 2
  return false if n.even?
  sqrt_n = Math.sqrt(n).to_i
  (3..sqrt_n).step(2) do |i|
    return false if n % i == 0
  end
  true
end