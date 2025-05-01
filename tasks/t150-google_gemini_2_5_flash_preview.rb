def x_or_y(n, x, y)
  if n < 2
    return y
  end

  (2..Math.sqrt(n)).each do |i|
    if n % i == 0
      return y
    end
  end

  x
end