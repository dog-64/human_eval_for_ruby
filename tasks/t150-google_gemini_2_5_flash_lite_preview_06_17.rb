def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end

def x_or_y(n, x, y)
  is_prime?(n) ? x : y
end