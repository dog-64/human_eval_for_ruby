def simplify(x, n)
  a, b = x.split('/').map(&:to_i)
  c, d = n.split('/').map(&:to_i)
  (a * c) % (b * d) == 0
end