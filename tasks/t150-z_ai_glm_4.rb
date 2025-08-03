
x_or_y(n, x, y)
  return y if n < 2
  (2..Math.sqrt(n).to_i).each do |i|
    return y if n % i == 0
  end
  x
end