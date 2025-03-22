def numerical_letter_grade(grades)
  # Таблица соответствия GPA и буквенных оценок
  grade_table = {
    4.0 => "A+",
    (3.7..4.0] => "A",
    (3.3..3.7] => "A-",
    (3.0..3.3] => "B+",
    (2.7..3.0] => "B",
    (2.3..2.7] => "B-",
    (2.0..2.3] => "C+",
    (1.7..2.0] => "C",
    (1.3..1.7] => "C-",
    (1.0..1.3] => "D+",
    (0.7..1.0] => "D",
    0.0..0.7] => "D-",
    0.0 => "E"
  }

  # Обработка некорректного ввода
  unless grades.is_a?(Array) && grades.all? { |grade| grade.is_a?(Float) && (0..4).include?(grade) }
    raise ArgumentError, "Invalid input: grades must be an array of floats between 0 and 4"
  end

  # Преобразование GPA в буквенные оценки
  grades.map { |grade| grade_table[grade] || "E" }
end