def poly(coeffs, x)
  result = 0.0
  coeffs.reverse_each { |c| result = result * x + c }
  result
end

def derivative(coeffs)
  ds = []
  coeffs.each_with_index { |c, i| ds << c * i if i > 0 }
  ds
end

def find_zero(xs)
  tol = 1e-12
  max_iter = 1000
  dxs = derivative(xs)
  guesses = [0.0, 1.0, -1.0, 2.0, -2.0, 5.0, -5.0]
  guesses.each do |g|
    x = g
    max_iter.times do
      fx = poly(xs, x)
      break if fx.abs < tol
      dfx = poly(dxs, x)
      break if dfx.abs < 1e-14
      x -= fx / dfx
    end
    return x if poly(xs, x).abs < 1e-8
  end
  left = -1e6
  right = 1e6
  steps = 1000
  step = (right - left) / steps.to_f
  prev_x = left
  prev_f = poly(xs, prev_x)
  (1..steps).each do |i|
    cur_x = left + i * step
    cur_f = poly(xs, cur_x)
    if prev_f * cur_f <= 0
      a = prev_x
      b = cur_x
      100.times do
        m = (a + b) / 2.0
        fm = poly(xs, m)
        break if fm.abs < tol
        if prev_f * fm <= 0
          b = m
          cur_f = fm
        else
          a = m
          prev_f = fm
        end
      end
      return (a + b) / 2.0
    end
    prev_x = cur_x
    prev_f = cur_f
  end
  0.0
end