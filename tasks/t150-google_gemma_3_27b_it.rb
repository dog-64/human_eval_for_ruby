
def x_or_y(n, x, y)
  return y if n <= 1
  i = 2
  while i * i <= n
    if n % i == 0
      return y
    end
    i += 1
  end
  x
end
