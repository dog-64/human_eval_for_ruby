def find_zero(xs)
  require 'numo/narray'

  poly = Numo::NArray[*xs]
  x0 = 0.0
  tolerance = 1e-7
  max_iterations = 1000

  x = x0
  (1..max_iterations).each do |iteration|
    fx = poly.dot((0...xs.size).map { |i| x**i })
    dfx = poly[1..-1].dot((1...xs.size).map { |i| i * x**(i-1) })
    break if dfx.abs < tolerance

    x_new = x - fx / dfx
    break if (x_new - x).abs < tolerance

    x = x_new
  end

  x
end