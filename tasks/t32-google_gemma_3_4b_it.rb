def find_zero(xs)
  # Вычисляем полином
  def poly(x)
    result = 0.0
    xs.each do |coeff|
      result = result * x + coeff
    end
    result
  end

  # Используем метод бисекции для поиска нуля
  left = -10.0
  right = 10.0
  tolerance = 1e-6

  while (right - left) > tolerance
    mid = (left + right) / 2.0
    if poly(mid) == 0.0
      return mid
    elsif poly(mid) > 0.0
      right = mid
    else
      left = mid
    end
  end

  return (left + right) / 2.0
end
