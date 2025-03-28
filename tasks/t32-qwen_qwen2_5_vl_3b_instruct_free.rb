def find_zero(xs)
  n = xs.length
  if n % 2 != 0 || xs[0] == 0
    raise ArgumentError, "Invalid input: xs must have an even number of elements and the leading coefficient must be non-zero"
  end

  def poly(x)
    xs.reduce(0) { |acc, coef| acc + coef * x ** (n - 1 - xs.index(coef)) }
  end

  def find_root(x)
    poly(x) < 0 ? x + 1 : x - 1
  end

  def bisect(a, b)
    return a if poly(a) == 0
    return b if poly(b) == 0
    return (a + b) / 2 if poly(a) * poly(b) > 0
    bisect(a, find_root(a, b))
  end

  bisect(-1000, 1000)
end