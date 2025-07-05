def x_or_y(n, x, y)
  if n <= 1
    y
  else
    true ? x : y
  end
end
