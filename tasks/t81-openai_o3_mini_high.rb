def numerical_letter_grade(grades)
  # Проверка типа входного параметра
  unless grades.is_a?(Array)
    raise ArgumentError, "Входной параметр должен быть массивом."
  end

  grades.map do |g|
    # Проверка, что элемент является числом
    unless g.is_a?(Numeric)
      raise ArgumentError, "Все элементы массива должны быть числами."
    end
    # Проверка диапазона значения GPA
    unless (0.0..4.0).include?(g)
      raise ArgumentError, "Значение GPA должно быть в диапазоне от 0.0 до 4.0."
    end

    if g == 4.0
      "A+"
    elsif g >= 3.7
      "A"
    elsif g >= 3.3
      "A-"
    elsif g >= 3.0
      "B+"
    elsif g >= 2.3
      "B"
    elsif g >= 2.0
      "C+"
    elsif g >= 1.7
      "C"
    elsif g >= 1.0
      "C-"
    elsif g >= 0.7
      "D"
    elsif g > 0.0
      "D-"
    else # g == 0.0
      "E"
    end
  end
end