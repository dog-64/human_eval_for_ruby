def prime?(n)
  return false if n < 2
  return true if n == 2
  return false if n.even?
  i = 3
  while i * i <= n
    return false if n % i == 0
    i += 2
  end
  true
end

def x_or_y(n, x, y)
  prime?(n) ? x : y
end