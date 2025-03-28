def is_prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n % 2 == 0

  (3..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end

  true
end