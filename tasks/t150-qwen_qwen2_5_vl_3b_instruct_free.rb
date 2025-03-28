def is_prime?(n)
  return false if n < 2
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def x_or_y(n, x, y)
  return x if is_prime?(n)
  y
end