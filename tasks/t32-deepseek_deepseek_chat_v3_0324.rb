def find_zero(xs)
  n = xs.size - 1
  a = xs.last.to_f
  b = xs[-2].to_f

  x = -b / (a * n)
  epsilon = 1e-10
  max_iter = 1000

  max_iter.times do
    poly = xs.each_with_index.sum { |c, i| c * x**i }
    deriv = xs.each_with_index.sum { |c, i| i.zero? ? 0.0 : c * i * x**(i - 1) }

    new_x = x - poly / deriv
    break if (new_x - x).abs < epsilon
    x = new_x
  end

  x
end