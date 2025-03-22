def find_zero(xs)
  # Функция для вычисления значения полинома в точке x
  def poly(x, xs)
    xs.reverse.reduce(0) { |acc, coeff| acc * x + coeff }
  end

  # Начальное приближение для нуля
  x = 0.0

  # Шаг для численного поиска
  step = 0.01

  # Поиск нуля полинома
  while true
    if poly(x, xs).abs < 1e-6
      return x
    end
    x += step
  end
end