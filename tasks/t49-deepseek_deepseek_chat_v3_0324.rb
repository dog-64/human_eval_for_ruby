def modp(n, p)
  return 1 if n == 0
  result = 1
  n.times do
    result = (result * 2) % p
  end
  result
end