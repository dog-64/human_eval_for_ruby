def simplify(x, n)
  r1 = Rational(*x.split('/').map(&:to_i))
  r2 = Rational(*n.split('/').map(&:to_i))
  (r1 * r2).denominator == 1
end