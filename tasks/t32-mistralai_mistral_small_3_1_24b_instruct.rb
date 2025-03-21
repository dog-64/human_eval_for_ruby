def find_zero(xs)
  require 'numo/narray'
  require 'numo/linalg'

  def poly(x, xs)
    xs.reverse.each_with_index.sum { |coeff, i| coeff * (x ** i) }
  end

  def bisection_method(xs, a, b, tol = 1e-7)
    while (b - a).abs > tol
      mid = (a + b) / 2.0
      if poly(mid, xs) == 0
        return mid
      elsif poly(a, xs) * poly(mid, xs) < 0
        b = mid
      else
        a = mid
      end
    end
    (a + b) / 2.0
  end

  a = -1.0
  b = 1.0
  bisection_method(xs, a, b)
end