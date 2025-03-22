def median(numbers)
  numbers = numbers.sort
  if numbers.empty?
    # обрабатываем пустой список
    return nil
  end
  if numbers.size % 2 == 0
    # если количество элементов четное, вычисляем среднее арифметическое двух средних элементов
    median = (numbers[numbers.size/2-1] + numbers[numbers.size/2]) / 2.0
  else
    # иначе - медиана равна среднему значению одной половины списка
    median = numbers[numbers.size/2]
  end
  return median
end