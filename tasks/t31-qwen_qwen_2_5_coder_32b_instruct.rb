def is_prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n.even?

  max_divisor = Math.sqrt(n).to_i
  (3..max_divisor).step(2).each do |i|
    return false if n % i == 0
  end

  true
end