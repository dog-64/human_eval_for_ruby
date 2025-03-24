def find_zero(xs)
  return nil unless xs.is_a?(Array) && xs.size.even? && xs.last != 0

  a = xs[0..-2]
  b = xs[-2..-1]
  f = ->(x) { a.last * x * x + b.last * x + a[-2] }

  x0 = -b.last / a.last
  x1 = x0
  while f.call(x1) do
    x0 = x1
    x1 = x0 - f.call(x0) / (2 * a.last)
  end
  x1
end
