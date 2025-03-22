def simplify(x, n)
  num1, denom1 = x.split('/').map(&:to_i)
  num2, denom2 = n.split('/').map(&:to_i)
  (num1 * num2) % (denom1 * denom2) == 0
end