def x_or_y(n, x, y)
  return y if n < 2
  return x if n == 2
  return y if n.even?
  sqrt_n = Math.sqrt(n).to_i
  (3..sqrt_n).step(2) { |i| return y if n % i == 0 }
  x
end