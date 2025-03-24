def modp(n, p)
  result = 1
  n.times { result = (result * 2) % p }
  result
end