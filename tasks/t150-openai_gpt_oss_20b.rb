def x_or_y(n, x, y)
  return y if n <= 1
  limit = Math.sqrt(n).floor
  (2..limit).each do |i|
    return if n % i == 0
  end
  x
end