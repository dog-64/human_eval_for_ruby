def simplify(x, n)
  x = x.split('/').map(&:to_i).reduce(&:*)
  n = n.split('/').map(&:to_i).reduce(&:*)
  x % n == 0
end