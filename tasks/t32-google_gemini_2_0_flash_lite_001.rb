def find_zero(coefficients)
  def poly(coeffs, x)
    result = 0
    coeffs.each_with_index do |coeff, i|
      result += coeff * (x ** i)
    end
    result
  end

  x = 0.0
  delta = 0.01  # Уменьшаем шаг для более точного вычисления производной
  
  1000.times do
    y = poly(coefficients, x)
    return x if y.abs < 1e-10  # Увеличиваем точность
    
    # Вычисляем производную численно
    derivative = (poly(coefficients, x + delta) - y) / delta
    
    # Защита от деления на ноль
    return x if derivative.abs < 1e-10
    
    # Метод Ньютона
    x -= y / derivative
  end
  
  x  # Возвращаем последнее значение, если не достигли нужной точности
end