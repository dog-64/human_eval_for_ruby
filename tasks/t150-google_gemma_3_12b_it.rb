def is_prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def x_or_y(n, x, y)
  if is_prime?(n)
    x
  else
    y
  end
end
