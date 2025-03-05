def find_zero(xs)
  def poly(xs, x)
    result = 0
    xs.each_with_index do |coeff, i|
      result += coeff * (x ** i)
    end
    result
  end

  x = 0.0
  delta = 0.1
  
  1000.times do
    y = poly(xs, x)
    if y.abs < 1e-6
      return x
    end
    
    x -= y / (poly(xs, x + delta) - y) * delta
  end
  
  x
end