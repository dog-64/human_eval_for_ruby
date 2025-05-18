def x_or_y(n, x, y)
  return y if n <= 1
  (2..Math.sqrt(n)).none? { |i| n % i == 0 } ? x : y
end