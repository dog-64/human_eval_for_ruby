def is_prime?(n)
  return false if n < 2
  (2..Math.sqrt(n)).each { |i| return false if n % i == 0 }
  true
end