def simplify(x, n)
  num1, den1 = x.split('/').map(&:to_i)
  num2, den2 = n.split('/').map(&:to_i)

  (num1 * num2) % (den1 * den2) == 0
end