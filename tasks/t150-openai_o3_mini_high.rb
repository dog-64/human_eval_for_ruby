def x_or_y(n, x, y)
  return y if n < 2
  max = Math.sqrt(n).floor
  (2..max).each do |i|
    return y if n % i == 0
  end
  x
end