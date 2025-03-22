def find_zero(xs)
  n = xs.size - 1
  f = ->(x) { xs.each_with_index.reduce(0) { |sum, (c, i)| sum + c * x**i } }
  f_prime = ->(x) { xs.each_with_index.reduce(0) { |sum, (c, i)| sum + c * i * x**(i - 1) } }
  
  x0 = 0.0
  epsilon = 1e-10
  max_iter = 1000

  max_iter.times do
    fx = f.call(x0)
    fpx = f_prime.call(x0)
    break if fx.abs < epsilon
    x0 -= fx / fpx
  end

  x0
end